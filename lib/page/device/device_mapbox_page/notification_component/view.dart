import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/device/description_item.dart';
import 'package:supernodeapp/common/components/device/notification_item.dart';
import 'package:supernodeapp/common/components/picker/date_range_picker.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    NotificationState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  return MediaQuery.removePadding(
    removeTop: true,
    context: viewService.context,
    child: ListView(
      children: <Widget>[
        DescriptionItem(
          title: FlutterI18n.translate(_ctx, 'description'),
          content: 'Signal Test',
        ),
        DescriptionItem(
          title: FlutterI18n.translate(_ctx, 'alert_setting'),
          titleTrackWidget: Switch(
            activeColor: dartBlueColor,
            value: true,
            onChanged: (value) {},
          ),
          content: '2020-05-22 09:39:12',
        ),
        Container(
          margin: EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                FlutterI18n.translate(_ctx, 'out_of_border_notification'),
                style: kMiddleFontOfBlack,
              ),
              SizedBox(height: 20),
              DateRangePicker(
                firstTime: '2020-06-27',
                secondTime: '2020-06-27',
                thirdText: FlutterI18n.translate(_ctx, 'search'),
                firstTimeOnTap: (date) {},
                secondTimeOnTap: (date) {},
                onSearch: () {},
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        NotificationItem(
          onTap: () {
            dispatch(DeviceMapBoxActionCreator.changeTabDetailName(
                TabDetailPageEnum.Notification));
          },
        ),
        NotificationItem(
          onTap: () {
            dispatch(DeviceMapBoxActionCreator.changeTabDetailName(
                TabDetailPageEnum.Notification));
          },
        ),
      ],
    ),
  );
}
