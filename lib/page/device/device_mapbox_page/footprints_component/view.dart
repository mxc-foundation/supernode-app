import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/device/description_item.dart';
import 'package:supernodeapp/common/components/device/foot_prints_item.dart';
import 'package:supernodeapp/common/components/device/line_color.dart';
import 'package:supernodeapp/common/components/picker/date_range_picker.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    FootprintsState state, Dispatch dispatch, ViewService viewService) {
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
        LineColor(
          firstText: '> -100dBm',
          secondText: '-100~ -105',
          thirdText: '-105~ -110',
          firstColor: dbm100,
          secondColor: dbm100_105,
          thirdColor: dbm105_110,
        ),
        LineColor(
          firstText: '-110 ~ -115',
          secondText: '-115 ~ -120',
          thirdText: '< -120dBm',
          firstColor: dbm110_115,
          secondColor: dbm115_120,
          thirdColor: dbm120,
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
          padding: EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                FlutterI18n.translate(_ctx, 'confirm_tr'),
                style: kMiddleFontOfBlack,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: DateRangePicker(
                  firstTime: '2020-06-27',
                  secondTime: '2020-06-27',
                  thirdText: FlutterI18n.translate(_ctx, 'search'),
                  firstTimeOnTap: (date) {},
                  secondTimeOnTap: (date) {},
                  onSearch: () {},
                ),
              ),
            ],
          ),
        ),
        FootPrintsItem(
          onTap: () {
            dispatch(DeviceMapBoxActionCreator.changeTabDetailName(
                TabDetailPageEnum.Footprints));
          },
        ),
        FootPrintsItem(
          onTap: () {
            dispatch(DeviceMapBoxActionCreator.changeTabDetailName(
                TabDetailPageEnum.Footprints));
          },
        ),
        FootPrintsItem(
          onTap: () {
            dispatch(DeviceMapBoxActionCreator.changeTabDetailName(
                TabDetailPageEnum.Footprints));
          },
        ),
        FootPrintsItem(
          onTap: () {
            dispatch(DeviceMapBoxActionCreator.changeTabDetailName(
                TabDetailPageEnum.Footprints));
          },
        ),
      ],
    ),
  );
}
