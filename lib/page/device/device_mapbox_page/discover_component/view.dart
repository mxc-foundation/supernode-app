import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/device/description_item.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    DiscoverState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  return MediaQuery.removePadding(
    removeTop: true,
    context: viewService.context,
    child: ListView(
      children: <Widget>[
        DescriptionItem(
          title: FlutterI18n.translate(_ctx, 'device_ID'),
          content: 'SmartWatch02436',
        ),
        DescriptionItem(
          title: FlutterI18n.translate(_ctx, 'location'),
          content: 'Near Brückenstraße 4',
        ),
        DescriptionItem(
          title: FlutterI18n.translate(_ctx, 'address'),
          content: 'Brückenstraße 4 10967 Berlin Germany',
        ),
        DescriptionItem(
          title: FlutterI18n.translate(_ctx, 'tracking_border'),
          content: '10km',
          contentTrackWidget: InkWell(
            onTap: () {
              dispatch(DeviceMapBoxActionCreator.setBorderPromptVisible(true));
            },
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
               FlutterI18n.translate(_ctx, 'set_border'),
                style: kMiddleFontOfDarkBlueLink,
              ),
            ),
          ),
        ),
        DescriptionItem(
          title: FlutterI18n.translate(_ctx, 'alert_setting'),
          titleTrackWidget: Switch(
            activeColor: dartBlueColor,
            value: true,
            onChanged: (value) {},
          ),
          content:FlutterI18n.translate(_ctx, 'alert_setting_desc'),

        ),
      ],
    ),
  );
}
