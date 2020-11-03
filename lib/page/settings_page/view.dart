import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/profile.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/page/feedback_page/feedback.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SettingsState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => {
                  Navigator.of(viewService.context)
                      .pop({'username': state.username, 'email': state.email})
                }),
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          FlutterI18n.translate(_ctx, 'settings'),
          style: kBigFontOfBlack,
        ),
      ),
      body: pageBody(children: [
        panelFrame(
          child: profile(
            name: state.username,
            position: state.isAdmin ? FlutterI18n.translate(_ctx, 'admin') : '',
            trailing: state.isDemo
                ? Icon(Icons.do_not_disturb_alt)
                : Icon(Icons.chevron_right),
            onTap: state.isDemo
                ? null
                : () => dispatch(SettingsActionCreator.onSettings('profile')),
          ),
        ),
        panelFrame(
            child: Column(
          children: <Widget>[
            listItem(FlutterI18n.translate(_ctx, 'organization_setting'),
                trailing: state.isDemo ? Icon(Icons.do_not_disturb_alt) : null,
                onTap: state.isDemo
                    ? null
                    : () => dispatch(
                        SettingsActionCreator.onSettings('organization'))),
            Divider(),
            listItem(FlutterI18n.translate(_ctx, 'security_setting'),
                trailing: state.isDemo ? Icon(Icons.do_not_disturb_alt) : null,
                onTap: state.isDemo
                    ? null
                    : () =>
                        dispatch(SettingsActionCreator.onSettings('security'))),
            Divider(),
            listItem(
              FlutterI18n.translate(_ctx, 'address_book'),
              onTap: () =>
                  dispatch(SettingsActionCreator.onSettings('address_book')),
              key: ValueKey('addressBookItem'),
            ),
            Divider(),
            // listItem(
            //   FlutterI18n.translate(_ctx,'notification'),
            //   trailing: CupertinoSwitch(
            //     activeColor: selectedColor,
            //     value: state.notification,
            //     onChanged: (_) => dispatch(SettingsActionCreator.onSettings('notification'))
            //   )
            // ),
            // Divider(),
            listItem(FlutterI18n.translate(_ctx, 'language'),
                onTap: () =>
                    dispatch(SettingsActionCreator.onSettings('language'))),
            Divider(),
            listItem(FlutterI18n.translate(_ctx, 'about'),
                onTap: () =>
                    dispatch(SettingsActionCreator.onSettings('about'))),
            Divider(),
            listItem(FlutterI18n.translate(_ctx, 'connect_with_us'),
                onTap: () =>
                    dispatch(SettingsActionCreator.onSettings('links'))),
            Divider(),
            listItem(
              FlutterI18n.translate(_ctx, 'screenshot'),
              trailing: Switch(
                activeColor: Color(0xFF1C1478),
                value: DatadashFeedback.of(_ctx).showScreenshot,
                onChanged: (v) =>
                    dispatch(SettingsActionCreator.onSetScreenshot(v)),
              ),
            ),
            Divider(),
            listItem(FlutterI18n.translate(_ctx, 'logout'),
                key: Key('logout'),
                trailing: Text(''),
                onTap: () =>
                    dispatch(SettingsActionCreator.onSettings('logout'))),
          ],
        ))
      ]));
}
