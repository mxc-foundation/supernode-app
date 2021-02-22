import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/page/settings_page/profile_component/profile_page.dart';
import 'package:supernodeapp/theme/font.dart';

import '../../../route.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
        context: context,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          ListTile(
            title: Center(
                child: Text(FlutterI18n.translate(context, 'manage_account'),
                    style: kBigBoldFontOfBlack)),
            trailing: GestureDetector(
                child: Icon(Icons.close, color: Colors.black),
                onTap: () => Navigator.of(context).pop()),
          ),
          Divider(),
          listItem(FlutterI18n.translate(context, 'super_node'),
              onTap: () => Navigator.push(context, route((_) => ProfilePage())),
              leading: Image.asset(Token.mxc.imagePath, height: s(50))),
          Divider(),
          listItem(FlutterI18n.translate(context, 'datahighway_parachain'),
              onTap: () => 'TODO',//TODO dispatch(SettingsActionCreator.onSettings(SettingsOption.profileDhx)),
              leading: Image.asset(
                  Token.supernodeDhx.imagePath, height: s(50))),
        ]);
  }
}