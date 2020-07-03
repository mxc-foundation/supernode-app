import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/device/description_item.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    DiscoverState state, Dispatch dispatch, ViewService viewService) {
  return MediaQuery.removePadding(
    removeTop: true,
    context: viewService.context,
    child: ListView(
      children: <Widget>[
        DescriptionItem(
          title: 'Device ID',
          content: 'SmartWatch02436',
        ),
        DescriptionItem(
          title: 'Location',
          content: 'Near Brückenstraße 4',
        ),
        DescriptionItem(
          title: 'Address',
          content: 'Brückenstraße 4 10967 Berlin Germany',
        ),
        DescriptionItem(
          title: 'Tracking Border',
          content: '10km',
          contentTrackWidget: InkWell(
            onTap: (){
              dispatch(DeviceMapBoxActionCreator.setBorderPromptVisible(true));
            },
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                'Set Border',
                style: kMiddleFontOfDartBlueLink,
              ),
            ),
          ),
        ),
        DescriptionItem(
          title: 'Alert Setting',
          titleTrackWidget: Switch(
            activeColor: dartBlueColor,
            value: true,
            onChanged: (value) {},
          ),
          content:
              'You will be notified if the device goes out of your predefined data border.',
        ),
      ],
    ),
  );
}
