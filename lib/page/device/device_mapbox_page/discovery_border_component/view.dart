import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    DiscoveryBorderState state, Dispatch dispatch, ViewService viewService) {
  return  MediaQuery.removePadding(
    removeTop: true,
    context: viewService.context,
    child: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 18),
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Border : 2km',
            style: kMiddleFontOfGrey,
          ),
        ),
        Slider(
          activeColor: Color(0xFFFF5B5B),
          inactiveColor: Color(0xFFEBEFF2),
          value: state.gatewaySliderValue,
          onChanged: (value) {
            dispatch(DeviceMapBoxActionCreator.changeGatewaySliderValue(value));
          },
          //进度条上显示多少个刻度点
          max: 100,
          min: 0,
        ),
      ],
    ),
  );
}
