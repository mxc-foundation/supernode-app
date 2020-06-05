import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/map.dart';
import 'package:supernodeapp/common/components/widgets/component_widgets.dart';

import 'state.dart';

Widget buildView(mapboxState state, Dispatch dispatch, ViewService viewService) {
  final _ctx = viewService.context;

  return ScaffoldWidget(
    body: MapWidget(
      context: _ctx,
      userLocationSwitch: true,
      markers: state.gatewaysLocations ?? [],
      controller: state.mapCtl,
      isFullScreen: true,
      myLatLng: state.myLocation,
    ),
    useSafeArea: false,
  );
}
