import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:flutter_appcenter/flutter_appcenter.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';

import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/device/smart_watch_detail_page/page.dart';
import 'package:supernodeapp/page/sign_up_page/page.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'global_store/state.dart';
import 'page/add_gateway_page/page.dart';
import 'page/change_password_page/page.dart';
import 'page/set_2fa_page/page.dart';
import 'page/confirm_page/page.dart';
import 'page/deposit_page/page.dart';
import 'page/forgot_password_page/page.dart';
import 'page/stake_page/page.dart';
import 'page/withdraw_page/page.dart';
import 'page/home_page/page.dart';
import 'page/login_page/page.dart';
import 'page/splash_page/page.dart';
import 'page/mapbox_page//page.dart';

import 'page/settings_page/page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();

  runApp(mxcApp());
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
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Widget mxcApp() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final AbstractRoutes routes = PageRoutes(
      pages: <String, Page<Object, dynamic>>{
        'splash_page': SplashPage(),
        'login_page': LoginPage(),
        'sign_up_page': SignUpPage(),
        'forgot_password_page': ForgotPasswordPage(),
        'home_page': HomePage(),
        'deposit_page': DepositPage(),
        'withdraw_page': WithdrawPage(),
        'confirm_page': ConfirmPage(),
        'stake_page': StakePage(),
        'settings_page': SettingsPage(),
        'change_password_page': ChangePasswordPage(),
        'set_2fa_page': Set2FAPage(),
        'add_gateway_page': AddGatewayPage(),
        'mapbox_page': MapBoxPage(),
      'smart_watch_detail_page': SmartWatchDetailPage(),
      },
      visitor: (String path, Page<Object, dynamic> page) {
        if (page.isTypeof<GlobalBaseState>()) {
          page.connectExtraStore<GlobalState>(GlobalStore.store, (Object pagestate, GlobalState appState) {
            final GlobalBaseState p = pagestate;

            if (!(p.settings == appState.settings)) {
              if (pagestate is Cloneable) {
                final Object copy = pagestate.clone();
                final GlobalBaseState newState = copy;

                return newState..settings = appState.settings;
              }
            }

            return pagestate;
          });
        }
      });

  return MaterialApp(
    navigatorKey: navigatorKey,
    localizationsDelegates: [
      FlutterI18nDelegate(
        translationLoader: FileTranslationLoader(
          useCountryCode: true,
          // forcedLocale: Locale()
        )
        // translationLoader: NamespaceFileTranslationLoader(
        //   useCountryCode: true,
        //   namespaces: [ 'login' ]
        // )
      ),
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en'),
      const Locale.fromSubtags(languageCode: 'zh'),
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode:'CN'),
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode:'TW'),
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode:'HK'),
      const Locale.fromSubtags(languageCode: 'vi'), // Vietnam
      const Locale.fromSubtags(languageCode: 'ja'), // Japan
      const Locale.fromSubtags(languageCode: 'ko'), // Korea
      const Locale.fromSubtags(languageCode: 'de'), // Germany
      const Locale.fromSubtags(languageCode: 'ru'), // Russia
      const Locale.fromSubtags(languageCode: 'ko'), // Korea
      const Locale.fromSubtags(languageCode: 'tr'), // Turkey
    ],
    theme: appTheme,
    home: routes.buildPage('splash_page', null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return routes.buildPage(settings.name, settings.arguments);
        },
        settings: settings,
      );
    },
  );
}
