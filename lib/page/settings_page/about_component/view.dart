import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/subtitle.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'state.dart';

Widget buildView(AboutState state, Dispatch dispatch, ViewService viewService) {
  final _ctx = viewService.context;

  return Stack(
    children: <Widget>[
      pageFrame(
        context: viewService.context,
        padding: EdgeInsets.zero,
        children: [
          pageNavBar(
            FlutterI18n.translate(_ctx, 'about'),
            padding: const EdgeInsets.all(20),
            onTap: () => Navigator.of(viewService.context).pop(),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 30, bottom: 50),
            child: Image.asset(AppImages.splashLogo, height: 100),
          ),
          Divider(),
          listItem(
            FlutterI18n.translate(_ctx, 'impressum'),
            onTap: () => Tools.launchURL(Sys.impressum),
          ),
          Divider(),
          listItem(
            FlutterI18n.translate(_ctx, 'privacy_policy'),
            onTap: () => Tools.launchURL(Sys.privacyPolicy),
          ),
          Divider(),
          listItem(
            FlutterI18n.translate(_ctx, 'version'),
            onTap: () {},
            trailing: Container(
              padding: kInnerRowRight10,
              child: Text('v1.0.5', style: kMiddleFontOfGrey),
            ),
          ),
          Divider(),
        ],
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 30,
        child: Center(
          child: subtitle(
            '© 2020 ${FlutterI18n.translate(_ctx, 'foundation')}. ${FlutterI18n.translate(_ctx, 'all_rights')}',
          ),
        ),
      )
    ],
  );
}
