import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/page/login_page/login_generic.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_state.dart';
import '../../route.dart';
import 'about_component/about_page.dart';
import 'account_component/account_page.dart';
import 'address_book/address_book_picker.dart';
import 'app_settings/app_settings_page.dart';
import 'bloc/settings/cubit.dart';
import 'export_data/export_data_page.dart';
import 'links_component/links_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (a, b) => a.language != b.language,
      builder: (ctx, s) => Scaffold(
        appBar: AppBars.backArrowAppBar(
          context,
          title: FlutterI18n.translate(context, 'settings'),
          onPress: () => {Navigator.of(context).pop()},
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
          child: pageFrame(
            context: context,
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (a, b) => a.isDemo != b.isDemo,
                builder: (ctx, s) => listItem(
                    FlutterI18n.translate(context, 'manage_account'),
                    key: Key('manageAccountItem'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    trailing: s.isDemo ? Icon(Icons.do_not_disturb_alt) : null,
                    onTap: s.isDemo
                        ? null
                        : () => Navigator.push(
                            context, routeWidget(AccountPage()))),
              ),
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (a, b) => a.isDemo != b.isDemo,
                builder: (ctx, s) => listItem(
                    FlutterI18n.translate(context, 'app_settings'),
                    key: Key('appSettingsItem'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    trailing: s.isDemo ? Icon(Icons.do_not_disturb_alt) : null,
                    onTap: s.isDemo
                        ? null
                        : () => Navigator.push(
                            context, routeWidget(AppSettingsPage()))),
              ),
              listItem(
                FlutterI18n.translate(context, 'address_book'),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                onTap: () => Navigator.of(context)
                    .push(routeWidget(AddressBookPicker())),
                key: ValueKey('addressBookItem'),
              ),
              listItem(
                FlutterI18n.translate(context, 'about'),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                onTap: () {
                  context.read<SettingsCubit>().initAboutPage();
                  Navigator.push(context, routeWidget(AboutPage()));
                },
              ),
              listItem(
                FlutterI18n.translate(context, 'connect_with_us'),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                onTap: () => Navigator.push(
                  context,
                  routeWidget(LinksPage()),
                ),
              ),
              listItem(
                FlutterI18n.translate(context, 'rate_app'),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                onTap: () async {
                  try {
                    await launch(
                        "itms-apps://itunes.apple.com/app/id1509218470");
                  } on PlatformException catch (e) {
                    launch(
                        "https://play.google.com/store/apps/details?id=com.mxc.smartcity");
                  }
                },
              ),
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (a, b) => a.isDemo != b.isDemo,
                builder: (ctx, s) => listItem(
                  FlutterI18n.translate(context, 'export_mining_data'),
                  key: Key('export'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  onTap: () => s.isDemo
                      ? 'no action'
                      : Navigator.push(
                          context,
                          routeWidget(ExportDataPage()),
                        ),
                ),
              ),
              listItem(
                FlutterI18n.translate(context, 'logout'),
                key: Key('logout'),
                trailing: Text(''),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                onTap: () {
                  context.read<SupernodeCubit>().logout();
                  navigatorKey.currentState.pushAndRemoveUntil(
                      routeWidget(LoginPage()), (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
