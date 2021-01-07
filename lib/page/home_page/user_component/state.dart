import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

class UserState implements Cloneable<UserState> {
  //profile
  String selectedSuperNode = '';
  String id = '';
  String username = '';
  String password = '';
  String token = '';
  bool loading = true;
  Set loadingMap = {};

  bool isAdmin = false;
  bool isActive = false;
  String email = '';
  String note = '';

  List<OrganizationsState> organizations = [];

  //wallet
  double balance = 0;

  //stake
  double stakedAmount = 0;
  double totalRevenue = 0;

  //locked for pre-mining DHX
  double lockedAmount = 0;

  //gateways
  int gatewaysTotal = 0;
  double gatewaysRevenue = 0;
  double gatewaysUSDRevenue = 0;
  List<MapMarker> gatewaysLocations = [];

  //devices
  int devicesTotal = 0;
  double devicesRevenue = 0;
  double devicesUSDRevenue = 0;

  //map
  MapViewController mapViewController;
  StreamController<LatLng> markerlocationStream = StreamController();
  List geojsonList = [];

  bool isDemo = false;

  UserState();

  @override
  UserState clone() {
    return UserState()
      ..loading = loading
      ..loadingMap = loadingMap
      ..selectedSuperNode = selectedSuperNode
      ..id = id
      ..username = username
      ..password = password
      ..token = token
      ..isAdmin = isAdmin
      ..isActive = isActive
      ..email = email
      ..note = note
      ..organizations = organizations ?? []
      ..balance = balance
      ..stakedAmount = stakedAmount
      ..totalRevenue = totalRevenue
      ..lockedAmount = lockedAmount
      ..gatewaysTotal = gatewaysTotal
      ..gatewaysRevenue = gatewaysRevenue
      ..gatewaysUSDRevenue = gatewaysUSDRevenue
      ..devicesTotal = devicesTotal
      ..devicesRevenue = devicesRevenue
      ..devicesUSDRevenue = devicesUSDRevenue
      ..mapViewController = mapViewController
      ..markerlocationStream = markerlocationStream
      ..gatewaysLocations = gatewaysLocations
      ..geojsonList = geojsonList
      ..isDemo = isDemo;
  }

  UserState.fromMap(Map map, {String type = 'local'}) {
    id = map[UserDao.id] as String;
    username = map[UserDao.username] as String;
    token = map[UserDao.token] as String;
    isDemo = map['isDemo'] ?? false;
    isAdmin = type == 'local'
        ? (map[UserDao.isAdmin] == 1 ? true : false)
        : (map[UserDao.isAdmin] as bool);
    isActive = type == 'local'
        ? (map[UserDao.isActive] == 1 ? true : false)
        : (map[UserDao.isActive] as bool);
    email = map[UserDao.email] as String;
    note = map[UserDao.note] as String;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      UserDao.id: id,
      UserDao.username: username,
      UserDao.token: token,
      UserDao.isAdmin: isAdmin,
      UserDao.isActive: isActive,
      UserDao.email: email,
      UserDao.note: note,
    };

    return map;
  }
}

UserState initState(Map<String, dynamic> args) {
  

  return UserState();
}
