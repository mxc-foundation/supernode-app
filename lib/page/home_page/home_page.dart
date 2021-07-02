import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/main_common.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/mxc/cubit.dart';
import 'package:supernodeapp/page/home_page/device/view.dart';
import 'package:supernodeapp/page/home_page/gateway/view.dart';
import 'package:supernodeapp/page/home_page/wallet/view.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'cubit.dart';
import 'state.dart';
import 'bloc/supernode/user/cubit.dart';
import 'user/view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<NavigatorState> navigatorKey;

  @override
  void initState() {
    super.initState();
    final oldHomeNavigatorKey = homeNavigatorKey;
    navigatorKey = homeNavigatorKey = GlobalKey();
    if (oldHomeNavigatorKey != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        oldHomeNavigatorKey.currentState?.dispose();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupernodeCubit, SupernodeState>(
      buildWhen: (a, b) => a.session != b.session,
      builder: (ctx, supernode) =>
          BlocBuilder<DataHighwayCubit, DataHighwayState>(
        builder: (ctx, datahighway) => MultiBlocProvider(
          child: WillPopScope(
            onWillPop: () async {
              if (navigatorKey.currentState.canPop()) {
                navigatorKey.currentState.pop();
                return false;
              }
              return true;
            },
            child: Navigator(
              key: navigatorKey,
              onPopPage: (route, result) {
                return route.didPop(result);
              },
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MxcApp.fishRoutes
                        .buildPage(settings.name, settings.arguments);
                  },
                  settings: settings,
                );
              },
              onGenerateInitialRoutes: (state, s) => [
                route((ctx) => _HomePageContent()),
              ],
            ),
          ),
          providers: [
            BlocProvider(
              create: (ctx) => HomeCubit(
                supernodeUsername: supernode?.session?.username,
                cacheRepository: ctx.read<CacheRepository>(),
                supernodeUsed: supernode.session != null,
                parachainUsed: datahighway.session != null,
              )..initState(),
            ),
            BlocProvider(
              create: (ctx) => supernode.session == null
                  ? null
                  : (SupernodeUserCubit(
                      session: ctx.read<SupernodeCubit>().state.session,
                      orgId: ctx.read<SupernodeCubit>().state.orgId,
                      supernodeRepository: ctx.read<SupernodeRepository>(),
                      cacheRepository: ctx.read<CacheRepository>(),
                      homeCubit: ctx.read<HomeCubit>(),
                    )..initState()),
            ),
            BlocProvider(
              create: (ctx) => SettingsCubit(
                appCubit: ctx.read<AppCubit>(),
                supernodeUserCubit: ctx.read<SupernodeUserCubit>(),
                supernodeCubit: ctx.read<SupernodeCubit>(),
                supernodeRepository: ctx.read<SupernodeRepository>(),
              ),
            ),
            BlocProvider(
              create: (ctx) => supernode.session == null
                  ? null
                  : (SupernodeDhxCubit(
                      session: ctx.read<SupernodeCubit>().state.session,
                      orgId: ctx.read<SupernodeCubit>().state.orgId,
                      supernodeRepository: ctx.read<SupernodeRepository>(),
                      cacheRepository: ctx.read<CacheRepository>(),
                      homeCubit: ctx.read<HomeCubit>(),
                    )..initState()),
            ),
            BlocProvider(
              create: (ctx) => supernode.session == null
                  ? null
                  : (SupernodeBtcCubit(
                      session: ctx.read<SupernodeCubit>().state.session,
                      orgId: ctx.read<SupernodeCubit>().state.orgId,
                      supernodeRepository: ctx.read<SupernodeRepository>(),
                      homeCubit: ctx.read<HomeCubit>(),
                    )..initState()),
            ),
            BlocProvider(
              create: (ctx) => supernode.session == null
                  ? null
                  : (SupernodeMxcCubit(
                      orgId: ctx.read<SupernodeCubit>().state.orgId,
                      supernodeRepository: ctx.read<SupernodeRepository>(),
                      cacheRepository: ctx.read<CacheRepository>(),
                      homeCubit: ctx.read<HomeCubit>(),
                    )..initState()),
            ),
            BlocProvider(
              create: (ctx) => supernode.session == null
                  ? null
                  : (GatewayCubit(
                      orgId: ctx.read<SupernodeCubit>().state.orgId,
                      supernodeRepository: ctx.read<SupernodeRepository>(),
                      homeCubit: ctx.read<HomeCubit>(),
                    )..initState()),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  BottomNavigationBarItem _menuItem(
          BuildContext ctx, String text, bool selected,
          {bool disabled = false}) =>
      BottomNavigationBarItem(
        icon: Image.asset(
          AppImages.bottomBarMenus[text.toLowerCase()],
          color: () {
            if (selected) return selectedColor;
            if (disabled) return Colors.grey.shade200;
            return unselectedColor;
          }(),
          key: ValueKey('bottomNavBar_$text'),
        ),
        title: Text(
          FlutterI18n.translate(ctx, text.toLowerCase()),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (a, b) => a.tabIndex != b.tabIndex,
        builder: (ctx, s) {
          switch (s.tabIndex) {
            case HomeCubit.HOME_TAB:
              return UserTab();
            case HomeCubit.WALLET_TAB:
              return WalletTab();
            case HomeCubit.MINER_TAB:
              return GatewayTab();
            case HomeCubit.DEVICE_TAB:
              return DeviceTab();
            default:
              throw UnimplementedError('Unknown tab ${s.tabIndex}');
          }
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (a, b) =>
              a.tabIndex != b.tabIndex || a.parachainUsed != b.parachainUsed,
          builder: (ctx, s) => BottomNavigationBar(
              key: ValueKey('bottomNavBar'),
              type: BottomNavigationBarType.fixed,
              currentIndex: s.tabIndex,
              selectedItemColor: selectedColor,
              unselectedItemColor: unselectedColor,
              onTap: (i) {
                if ((i == HomeCubit.MINER_TAB || i == HomeCubit.DEVICE_TAB) &&
                    !context.read<HomeCubit>().state.supernodeUsed) return;
                context.read<HomeCubit>().changeTab(i);
              },
              items: [
                _menuItem(ctx, 'Home', s.tabIndex == HomeCubit.HOME_TAB),
                _menuItem(ctx, 'Wallet', s.tabIndex == HomeCubit.WALLET_TAB),
                _menuItem(ctx, 'Gateway', s.tabIndex == HomeCubit.MINER_TAB,
                    disabled: !s.supernodeUsed),
                _menuItem(ctx, 'Device', s.tabIndex == HomeCubit.DEVICE_TAB,
                    disabled: !s.supernodeUsed),
              ]),
        ),
      ),
    );
  }
}
