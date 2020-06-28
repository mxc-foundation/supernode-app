import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_icon_nav_bar.dart';
import 'package:supernodeapp/common/components/picker/date_range_picker.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    SmartWatchDetailState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  return pageFrame(
    context: _ctx,
    children: [
      _buildNavBar(_ctx),
      _buildSmartDetail(_ctx),
      Container(
        padding: EdgeInsets.only(top: 30),
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
    ],
  );
}

Widget _buildNavBar(BuildContext ctx) {
  return pageIconNavBar(
    leading: Container(
      margin: EdgeInsets.only(right: 8),
      child: Icon(
        Icons.watch,
        size: 22,
      ),
    ),
    title: Text(
      FlutterI18n.translate(ctx, 'my_sw'),
      style: kBigFontOfBlack,
    ),
    onTap: () {
      Navigator.pop(ctx);
    },
  );
}

Widget _buildSmartDetailItem({String title, String des}) {
  return Container(
    padding: EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title ?? "",
          style: kMiddleFontOfBlack,
        ),
        SizedBox(height: 8),
        Text(
          des ?? "",
          style: kMiddleFontOfGrey,
        ),
      ],
    ),
  );
}

Widget _buildSmartDetail(ctx) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSmartDetailItem(title: FlutterI18n.translate(ctx, 'description'), des: 'Test'),
        _buildSmartDetailItem(title: FlutterI18n.translate(ctx, 'last_seen'), des: '2020-05-22 09:39:12'),
        _buildSmartDetailItem(title: FlutterI18n.translate(ctx, 'device_ID'),des: 'SmartWatch02436'),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            FlutterI18n.translate(ctx, 'goto_bluetooth_setting'),
            style: kMiddleFontOfBlueLink,
          ),
        ),
      ],
    ),
  );
}
