import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/widgets/scaffold_widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DeviceMapBoxState state, Dispatch dispatch, ViewService viewService) {
  return ScaffoldWidget(
    body: Stack(
      children: <Widget>[
        MapBoxWidget(
          config: state.mapCtl,
          userLocationSwitch: true,
          isFullScreen: true,
        ),
        state.showIntroduction
            ? Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                ),
              )
            : SizedBox(),
        state.showIntroduction
            ? Positioned(
                bottom: 0,
                top: 80,
                left: 0,
                right: 0,
                child: viewService.buildComponent('introduction'),
              )
            : SizedBox(),
      ],
    ),
    useSafeArea: false,
  );
}
