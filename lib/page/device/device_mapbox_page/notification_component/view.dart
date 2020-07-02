import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/device/description_item.dart';
import 'package:supernodeapp/common/components/device/notification_item.dart';
import 'package:supernodeapp/common/components/picker/date_range_picker.dart';
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
          title: 'Description',
          content: 'Signal Test',
        ),
        DescriptionItem(
          title: 'Device ID',
          content: 'Oracle02436',
        ),
        DescriptionItem(
          title: 'Last Seen',
          content: '2020-05-22 09:39:12',
        ),
        Container(
          margin: EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Out of Border Notification',
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
        NotificationItem(),
        NotificationItem(),
      ],
    ),
  );
}
