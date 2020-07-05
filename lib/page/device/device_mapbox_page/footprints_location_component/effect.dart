import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'action.dart';
import 'state.dart';

Effect<FootPrintsLocationState> buildEffect() {
  return combineEffects(<Object, Effect<FootPrintsLocationState>>{
    FootPrintsLocationAction.resetToDefault: _resetToDefault,
  });
}

void _resetToDefault(Action action, Context<FootPrintsLocationState> ctx) {
  ctx.state.mapCtl.removeAll();
  var center= LatLng(37.386, -122.083);
  ctx.state.mapCtl?.removeAll();
  ctx.state.mapCtl.removeAll();
  ctx.state.mapCtl.addCircle(
    CircleOptions(
      geometry: center,
      circleColor: "#FF0000",
      circleRadius: 5,
    ),
  );
  ctx.state.mapCtl.addSymbol(
    MapMarker(
      size: 2,
      image: 'assets/images/device/PIN.png',
      point: center,
      iconOffset: Offset(0, -10),
    ),
  );
}
