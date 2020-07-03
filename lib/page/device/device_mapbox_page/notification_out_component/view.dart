import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/device/description_item.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    NotificationOutState state, Dispatch dispatch, ViewService viewService) {
  return MediaQuery.removePadding(
    removeTop: true,
    context: viewService.context,
    child: Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30, left: 16, right: 16),
            child: Text('2020-05-22 09:39:12', style: kMiddleFontOfBlack),
          ),
          DescriptionItem(
            title: 'Location',
            content: 'Near Brückenstraße 4',
          ),
          DescriptionItem(
            title: 'Address',
            content: 'Brückenstraße 4 10967 Berlin Germany',
          ),
        ],
      ),
    ),
  );
}
