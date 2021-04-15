import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:flutter_appcenter/flutter_appcenter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/common/repositories/coingecko_repository.dart';
import 'package:supernodeapp/common/utils/no_glow_behavior.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/common/repositories/storage_repository.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/page/feedback_page/feedback.dart';
import 'package:supernodeapp/page/address_book_page/add_address_page/page.dart';
import 'package:supernodeapp/page/address_book_page/address_details_page/page.dart';
import 'package:supernodeapp/page/address_book_page/page.dart';
import 'package:supernodeapp/page/calculator_list_page/page.dart';
import 'package:supernodeapp/page/calculator_page/page.dart';
import 'package:supernodeapp/page/connectivity_lost_page/page.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/page.dart';
import 'package:supernodeapp/page/gateway_profile_page/page.dart';
import 'package:supernodeapp/page/home_page/home_page.dart';
import 'package:supernodeapp/page/list_councils/page.dart';
import 'package:supernodeapp/page/login_page/login_generic.dart';
import 'package:supernodeapp/page/mapbox_gl_page/page.dart';
import 'package:supernodeapp/page/mining_simulator_page/page.dart';
import 'package:supernodeapp/page/lock_page/join_council/page.dart';
import 'package:supernodeapp/page/lock_page/confirm_lock_page/page.dart';
import 'package:supernodeapp/page/lock_page/page.dart';
import 'package:supernodeapp/page/lock_page/prepare_lock_page/page.dart';
import 'package:supernodeapp/page/lock_page/result_lock_page/page.dart';
import 'package:supernodeapp/page/stake_page/confirm_stake_page/page.dart';
import 'package:supernodeapp/page/stake_page/details_stake_page/page.dart';
import 'package:supernodeapp/page/stake_page/list_unstake_page/page.dart';
import 'package:supernodeapp/page/stake_page/prepare_stake_page/page.dart';
import 'package:supernodeapp/page/under_maintenance_page/page.dart';
import 'package:supernodeapp/page/wechat_bind_new_acc_page/page.dart';
import 'package:supernodeapp/page/wechat_bind_page/page.dart';
import 'package:supernodeapp/page/wechat_login_page/page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'app_cubit.dart';
import 'app_state.dart';
import 'page/add_gateway_page/page.dart';
import 'page/change_password_page/page.dart';
import 'page/device/choose_application_page/page.dart';
import 'page/get_2fa_page/page.dart';
import 'page/set_2fa_page/page.dart';
import 'page/confirm_page/page.dart';
import 'page/forgot_password_page/page.dart';
import 'page/stake_page/page.dart';

List<BlocListener> listeners() => [
      BlocListener<SupernodeCubit, SupernodeState>(
        listenWhen: (a, b) => a.orgId != b.orgId,
        listener: (context, state) {
          context.read<StorageRepository>().setOrganizationId(state.orgId);
        },
      ),
      BlocListener<SupernodeCubit, SupernodeState>(
        listenWhen: (a, b) => a.session != b.session,
        listener: (context, state) {
          context.read<StorageRepository>().setSupernodeSession(
                jwt: state.session?.token,
                userId: state.session?.userId,
                username: state.session?.username,
                password: state.session?.password,
                supernode: state.session?.node,
              );
        },
      ),
      BlocListener<AppCubit, AppState>(
        listenWhen: (a, b) => a.isDemo != b.isDemo,
        listener: (context, state) {
          context.read<StorageRepository>().setIsDemo(state.isDemo);
        },
      ),
      BlocListener<AppCubit, AppState>(
        listenWhen: (a, b) => a.locale != b.locale,
        listener: (context, state) {
          context.read<StorageRepository>().setIsDemo(state.isDemo);
        },
      ),
    ];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('assets/.env');

  final storageRepository = StorageRepository();
  await storageRepository.init();

  final cacheRepository = CacheRepository();
  await cacheRepository.init();

  final appCubit = AppCubit(isDemo: storageRepository.isDemo() ?? false);

  final supernodeSession = storageRepository.supernodeSession();
  final supernodeCubit = SupernodeCubit(
    orgId: storageRepository.organizationId(),
    session: supernodeSession != null
        ? SupernodeSession(
            token: supernodeSession.jwt,
            username: supernodeSession.username,
            password: supernodeSession.password,
            userId: supernodeSession.userId,
            node: supernodeSession.supernode,
          )
        : null,
  );

  final dataHighwaySession = storageRepository.dataHighwaySession();
  final dataHighwayCubit = DataHighwayCubit(
    session: dataHighwaySession != null
        ? DataHighwaySession(address: dataHighwaySession)
        : null,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>.value(
          value: appCubit,
        ),
        BlocProvider<SupernodeCubit>.value(
          value: supernodeCubit,
        ),
        BlocProvider<DataHighwayCubit>.value(
          value: dataHighwayCubit,
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SupernodeRepository>(
            create: (ctx) => SupernodeRepository(
                appCubit: appCubit, supernodeCubit: supernodeCubit),
          ),
          RepositoryProvider<ExchangeRepository>(
            create: (ctx) => ExchangeRepository(),
          ),
          RepositoryProvider.value(
            value: storageRepository,
          ),
          RepositoryProvider.value(
            value: cacheRepository,
          ),
        ],
        child: MultiBlocListener(
          listeners: listeners(),
          child: MxcApp(),
        ),
      ),
    ),
  );

  Stream.fromFuture(FlutterAppCenter.init(
    appSecretAndroid: Sys.appSecretAndroid,
    appSecretIOS: Sys.appSecretIOS,
    tokenAndroid: Sys.tokenAndroid,
    tokenIOS: Sys.tokenIOS,
    appIdIOS: Sys.appIdIOS,
    betaUrlIOS: Sys.betaUrlIOS,
    usePrivateTrack: false,
  ));

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  // RETHINK.TODO
  // CrashesDao().init(
  //   appSecretAndroid: Sys.appSecretAndroid,
  //   appSecretIOS: Sys.appSecretIOS,
  // );
}

class MxcApp extends StatelessWidget {
  static final AbstractRoutes fishRoutes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      // THESE ARE ONLY FISH REDUX PAGES.

      'forgot_password_page': ForgotPasswordPage(),
      'confirm_page': ConfirmPage(),
      'stake_page': StakePage(),
      'change_password_page': ChangePasswordPage(),
      'set_2fa_page': Set2FAPage(),
      'get_2fa_page': Get2FAPage(),
      'add_gateway_page': AddGatewayPage(),
      'choose_application_page': ChooseApplicationPage(),
      'device_mapbox_page': DeviceMapBoxPage(),
      'calculator_page': CalculatorPage(),
      'calculator_list_page': CalculatorListPage(),
      'address_book_page': AddressBookPage(),
      'add_address_page': AddAddressPage(),
      'address_details_page': AddressDetailsPage(),
      'connectivity_lost_page': ConnectivityLostPage(),
      'prepare_stake_page': PrepareStakePage(),
      'confirm_stake_page': ConfirmStakePage(),
      'details_stake_page': DetailsStakePage(),
      'list_unstake_page': ListUnstakePage(),
      'under_maintenance_page': UnderMaintenancePage(),
      'list_councils_page': ListCouncilsPage(),
      'mining_simulator_page': MiningSimulatorPage(),
      'lock_page': LockPage(),
      'prepare_lock_page': PrepareLockPage(),
      'join_council_page': JoinCouncilPage(),
      'confirm_lock_page': ConfirmLockPage(),
      'result_lock_page': ResultLockPage(),
      'gateway_profile_page': GatewayProfilePage(),
      'mapbox_gl_page': MapboxGlPage(),
      'wechat_login_page': WechatLoginPage(),
      'wechat_bind_page': WechatBindPage(),
      'wechat_bind_new_acc_page': WechatBindNewAccPage(),
    },
  );

  void showLoading(BuildContext context, AppState state) {
    if (!state.showLoading && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => Container(
            width: double.infinity,
            height: double.infinity,
            child: WillPopScope(
              onWillPop: () async => false,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: loadingView(),
              ),
            ),
          ),
        ),
        (r) => r.isFirst,
      );
    }
  }

  void showError(BuildContext context, AppState state) {
    tip(context, state.error.text, success: false);
  }

  Widget build(BuildContext context) {
    return DatadashFeedback(
      child: MaterialApp(
        navigatorKey: rootNavigatorKey,
        localizationsDelegates: [
          FlutterI18nDelegate(
            translationLoader: FileTranslationLoader(
              useCountryCode: true,
            ),
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale.fromSubtags(languageCode: 'zh'),
          const Locale.fromSubtags(
              languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
          const Locale.fromSubtags(
              languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
          const Locale.fromSubtags(
              languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'),
          const Locale.fromSubtags(languageCode: 'vi'), // Vietnam
          const Locale.fromSubtags(languageCode: 'ja'), // Japan
          const Locale.fromSubtags(languageCode: 'ko'), // Korea
          const Locale.fromSubtags(languageCode: 'de'), // Germany
          const Locale.fromSubtags(languageCode: 'ru'), // Russia
          const Locale.fromSubtags(languageCode: 'ko'), // Korea
          const Locale.fromSubtags(languageCode: 'tr'), // Turkey
          const Locale.fromSubtags(languageCode: 'es'), // Spain
          const Locale.fromSubtags(languageCode: 'pt'), // Portugal
          const Locale.fromSubtags(languageCode: 'id'), // Indonesia
          const Locale.fromSubtags(languageCode: 'tl'), // Philippines
        ],
        theme: appTheme,
        home: Builder(
          builder: (ctx) {
            ScreenUtil.instance
                .init(Config.BLUE_PRINT_WIDTH, Config.BLUE_PRINT_HEIGHT, ctx);
            return MultiBlocListener(
              listeners: [
                BlocListener<AppCubit, AppState>(
                  listenWhen: (a, b) => a.showLoading != b.showLoading,
                  listener: showLoading,
                ),
                BlocListener<AppCubit, AppState>(
                  listenWhen: (a, b) => a.error != b.error,
                  listener: showError,
                ),
              ],
              child: WillPopScope(
                onWillPop: () async {
                  if (homeNavigatorKey.currentState?.canPop() ?? false) {
                    homeNavigatorKey.currentState.maybePop();
                    return false;
                  }
                  if (navigatorKey.currentState.canPop()) {
                    navigatorKey.currentState.maybePop();
                    return false;
                  }
                  return true;
                },
                child: Navigator(
                  key: navigatorKey,
                  onPopPage: (route, result) => route.didPop(result),
                  onGenerateRoute: (RouteSettings settings) {
                    return MaterialPageRoute(
                      builder: (BuildContext context) {
                        return fishRoutes.buildPage(
                            settings.name, settings.arguments);
                      },
                      settings: settings,
                    );
                  },
                  onGenerateInitialRoutes: (state, s) => [
                    context.read<SupernodeCubit>().state.session == null
                        ? route((ctx) => LoginPage())
                        : route((ctx) => HomePage()),
                  ],
                ),
              ),
            );
          },
        ),
        builder: (context, child) {
          if (Platform.isAndroid) {
            return ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: child,
            );
          }
          return child;
        },
      ),
    );
  }
}

EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
