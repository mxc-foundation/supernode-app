import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';

import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/sign_up_page/page.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'global_store/state.dart';
import 'page/add_gateway_page/page.dart';
import 'page/change_password_page/page.dart';
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
  FlutterBugly.init(androidAppId: "d5abff150e", iOSAppId: "");
}

Widget mxcApp() {
  double textScale = 1;

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
        'add_gateway_page': AddGatewayPage(),
        'mapbox_page': mapboxPage(),
      },
      visitor: (String path, Page<Object, dynamic> page) {
        if (page.isTypeof<GlobalBaseState>()) {
          page.connectExtraStore<GlobalState>(GlobalStore.store,
              (Object pagestate, GlobalState appState) {
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
      const Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
      const Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
    ],
    theme: appTheme,
    home: routes.buildPage('splash_page', null),
    builder: (context, widget) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: textScale,
        ),
        child: widget,
      );
    },
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
