import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/location_utils.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/configs/config.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'action.dart';
import 'gateway_component/gateway_list_adapter/gateway_item_component/state.dart';
import 'state.dart';
import 'user_component/state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _initState,
    HomeAction.onOperate: _onOperate,
    HomeAction.onSettings: _onSettings,
    HomeAction.onProfile: _onProfile,
    HomeAction.onGateways: _onGateways,
    HomeAction.relogin: _relogin,
    HomeAction.mapbox: _mapbox,
  });
}

void _relogin(Action action, Context<HomeState> ctx) {
  Map data = {
    'username': StorageManager.sharedPreferences.getString(Config.USERNAME_KEY),
    'password': StorageManager.sharedPreferences.getString(Config.PASSWORD_KEY)
  };

  String apiRoot = StorageManager.sharedPreferences.getString(Config.API_ROOT);
  Dao.baseUrl = apiRoot;

  UserDao dao = UserDao();
  showLoading(ctx.context);
  dao.login(data).then((res) {
    log('login', res);
    hideLoading(ctx.context);

    SettingsState settingsData = GlobalStore.store.getState().settings;

    if (settingsData == null) {
      settingsData = SettingsState().clone();
    }

    Dao.token = res['jwt'];
    settingsData.token = res['jwt'];
    settingsData.username = data['username'];
    _profile(ctx);
  }).catchError((err) {
    hideLoading(ctx.context);
    ctx.dispatch(HomeActionCreator.loading(false));
    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = '';
    settingsData.selectedOrganizationId = '';
    settingsData.organizations = [];
    SettingsDao.updateLocal(settingsData);
    Navigator.of(ctx.context).pushReplacementNamed('login_page');
    tip(ctx.context, '$err');
  });
}

void _initState(Action action, Context<HomeState> ctx) {
  _profile(ctx);
  _getUserLocation(ctx);
}

Future<void> _getUserLocation(Context<HomeState> ctx) async {
  await LocationUtils.getLocation();
  if (LocationUtils.locationData != null) {
    ctx.dispatch(
      HomeActionCreator.onLocation(
        LatLng(LocationUtils.locationData.latitude, LocationUtils.locationData.longitude),
      ),
    );
  }
}

void _onProfile(Action action, Context<HomeState> ctx) {
  _profile(ctx);
}

void _onGateways(Action action, Context<HomeState> ctx) {
  _gateways(ctx);
}

void _profile(Context<HomeState> ctx) {
  UserDao dao = UserDao();

  dao.profile().then((res) async {
    log('profile', res);
    // hideLoading(ctx.context);

    UserState userData = UserState.fromMap(res['user'], type: 'remote');

    List<OrganizationsState> organizationsData = [];
    for (int index = 0; index < res['organizations'].length; index++) {
      organizationsData.add(OrganizationsState.fromMap(res['organizations'][index]));
    }

    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = userData.id;
    settingsData.organizations = organizationsData;
    if (settingsData.selectedOrganizationId.isEmpty) {
      settingsData.selectedOrganizationId = organizationsData.first.organizationID;
    }

    SettingsDao.updateLocal(settingsData);

    ctx.dispatch(HomeActionCreator.profile(userData, organizationsData));

    _gateways(ctx);
    _gatewaysLocations(ctx);
    // _devices(ctx,userData,settingsData.selectedOrganizationId);
    _balance(ctx, userData, settingsData.selectedOrganizationId);
    _miningIncome(ctx, userData, settingsData.selectedOrganizationId);
    _stakeAmount(ctx, settingsData.selectedOrganizationId);
  }).catchError((err) {
    ctx.dispatch(HomeActionCreator.onReLogin());
  });
}

void _balance(Context<HomeState> ctx, UserState userData, String orgId) {
  if (orgId.isEmpty) return;

  WalletDao dao = WalletDao();

  Map data = {'userId': userData.id, 'orgId': orgId};

  dao.balance(data).then((res) {
    log('balance', res);
    double balance = Tools.convertDouble(res['balance']);
    ctx.dispatch(HomeActionCreator.balance(balance));
  }).catchError((err) {
    tip(ctx.context, 'WalletDao balance: $err');
  });
}

void _miningIncome(Context<HomeState> ctx, UserState userData, String orgId) {
  WalletDao dao = WalletDao();

  Map data = {'userId': userData.id, 'orgId': orgId};

  dao.miningIncome(data).then((res) async {
    log('WalletDao miningInfo', res);
    double value = 0;
    if ((res as Map).containsKey('miningIncome')) {
      value = Tools.convertDouble(res['miningIncome']);
    }

    ctx.dispatch(HomeActionCreator.miningIncome(value));

    Map priceData = {
      'userId': userData.id,
      'orgId': orgId,
      'mxcPrice': '${value == 0.0 ? value.toInt() : value}'
    };

    _convertUSD(ctx, priceData, 'gateway');
  }).catchError((err) {
    tip(ctx.context, 'WalletDao miningInfo: $err');
  });
}

void _stakeAmount(Context<HomeState> ctx, String orgId) {
  if (orgId.isEmpty) return;

  StakeDao dao = StakeDao();

  dao.amount(orgId).then((res) async {
    log('StakeDao amount', res);
    double amount = 0;
    if (res.containsKey('actStake') && res['actStake'] != null) {
      amount = Tools.convertDouble(res['actStake']['Amount']);
    }

    ctx.dispatch(HomeActionCreator.stakedAmount(amount));
    ctx.dispatch(HomeActionCreator.loading(false));
  }).catchError((err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    tip(ctx.context, 'StakeDao amount: $err');
  });
}

void _gateways(Context<HomeState> ctx) {
  GatewaysDao dao = GatewaysDao();

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  Map data = {"organizationID": orgId, "offset": 0, "limit": 999};

  dao.list(data).then((res) async {
    log('GatewaysDao list', res);

    // [0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}
    // 用于匹配版本号 允许范围 0.0.0 -> 99.99.99
    var reg = RegExp(r"[0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}");

    int total = int.parse(res['totalCount']);
    // int allValues = 0;
    List<GatewayItemState> list = [];

    List tempList = res['result'] as List;

    if (tempList.length > 0) {
      for (int index = 0; index < tempList.length; index++) {
        // allValues += tempList[index]['location']['accuracy'];
        Iterable<Match> matches = reg.allMatches(tempList[index]['description']);
        String description = '';
        for (Match m in matches) {
          description = m.group(0);
        }

        tempList[index]['description'] = description;
        list.add(GatewayItemState.fromMap(tempList[index]));
      }
    }

    ctx.dispatch(HomeActionCreator.gateways(total, 0, list));
  }).catchError((err) {
    tip(ctx.context, 'GatewaysDao list: $err');
  });
}

void _gatewaysLocations(Context<HomeState> ctx) {
  GatewaysDao dao = GatewaysDao();

  dao.locations().then((res) async {
    log('GatewaysDao locations', res);

    if (res['result'].length > 0) {
      List<Marker> locations = [];
      for (int index = 0; index < res['result'].length; index++) {
        var location = res['result'][index]['location'];
        var marker = Marker(
          point: Tools.convertLatLng(location),
          builder: (ctx) => Image.asset(AppImages.gateways),
        );

        locations.add(marker);
      }
      ctx.dispatch(HomeActionCreator.gatewaysLocations(locations));
    }
  }).catchError((err) {
    tip(ctx.context, 'GatewaysDao locations: $err');
  });
}

void _devices(Context<HomeState> ctx, UserState userData, String orgId) {
  DevicesDao dao = DevicesDao();

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  Map data = {"organizationID": orgId, "offset": 0, "limit": 999};

  dao.list(data).then((res) async {
    log('DevicesDao list', res);

    int total = int.parse(res['totalCount']);
    double allValues = 0;

    ctx.dispatch(HomeActionCreator.devices(total, allValues));

    Map priceData = {
      'userId': userData.id,
      'orgId': orgId,
      'mxcPrice': '${allValues == 0.0 ? allValues.toInt() : allValues}'
    };

    var devicesUSDValue = await _convertUSD(ctx, priceData, 'device');
//     ctx.dispatch(HomeActionCreator.convertUSD('device', devicesUSDValue));
  }).catchError((err) {
    tip(ctx.context, 'DevicesDao list: $err');
  });
}

void _onOperate(Action action, Context<HomeState> ctx) {
  String act = action.payload;
  String page = '${act}_page';
  double balance = ctx.state.balance;
  List<OrganizationsState> organizations = ctx.state.organizations;

  if (act == 'unstake') {
    page = 'stake_page';
  }

  Navigator.pushNamed(ctx.context, page,
      arguments: {'balance': balance, 'organizations': organizations, 'type': act}).then((res) {
    if ((page == 'stake_page' || page == 'withdraw_page') && res) {
      _profile(ctx);
    }
  });
}

void _mapbox(Action action, Context<HomeState> ctx) {
  Navigator.pushNamed(
    ctx.context,
    'mapbox_page',
    arguments: {
      'markers': ctx.state.gatewaysLocations,
    },
  );
}

void _onSettings(Action action, Context<HomeState> ctx) {
  var curState = ctx.state;

  Map user = {
    'userId': curState.userId,
    'username': curState.username,
    'email': curState.email,
    'isAdmin': curState.isAdmin
  };

  List<OrganizationsState> organizations = ctx.state.organizations;

  Navigator.pushNamed(ctx.context, 'settings_page',
      arguments: {'user': user, 'organizations': organizations}).then((res) {
    if (res != null) {
      ctx.dispatch(HomeActionCreator.updateUsername(res));
    }

    _profile(ctx);
  });
}

Future<dynamic> _convertUSD(Context<HomeState> ctx, Map data, String type) {
  WalletDao dao = WalletDao();

  dao.convertUSD(data).then((res) async {
    log('WalletDao convertUSD', res);

    if ((res as Map).containsKey('mxcPrice')) {
      double value = double.parse(res['mxcPrice']);
      ctx.dispatch(HomeActionCreator.convertUSD(type, value));
    }
  }).catchError((err) {
    tip(ctx.context, 'WalletDao convertUSD: $err');
  });
}
