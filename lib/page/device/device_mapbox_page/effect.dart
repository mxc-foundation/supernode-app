import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'state.dart';

Effect<DeviceMapBoxState> buildEffect() {
  return combineEffects(<Object, Effect<DeviceMapBoxState>>{
    DeviceMapBoxAction.introductionVisible: _introductionVisible,
    DeviceMapBoxAction.setBorderPromptVisible: _setBorderPromptVisible,
    DeviceMapBoxAction.changeTabDetailName: _changeTabDetailName,
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<DeviceMapBoxState> ctx) {
  ctx.state.mapCtl.addSymbol(MapMarker(
    size: 1,
    image: 'assets/images/device/gatwary_location.png',
    point: LatLng(37.386, -122.083),
  ));
//  ctx.state.mapCtl.addSymbol(
//    CircleOptions(
//        geometry: LatLng(
//          center.latitude + sin(_circleCount * pi / 6.0) / 20.0,
//          center.longitude + cos(_circleCount * pi / 6.0) / 20.0,
//        ),
//        circleColor: "#FF0000"),
//  );
}

bool _changeTabDetailName(Action action, Context<DeviceMapBoxState> ctx) {
  ctx.state.dragPageState?.currentState?.setMiddleHeight();
  return false;
}

bool _introductionVisible(Action action, Context<DeviceMapBoxState> ctx) {
  bool visible = action.payload ?? false;
  if (!visible) {
    ctx.state.dragPageState?.currentState?.setMiddleHeight();
    ctx.dispatch((DeviceMapBoxActionCreator.setDragFrontWidgetVisible(true)));
  }
  return false;
}

bool _setBorderPromptVisible(Action action, Context<DeviceMapBoxState> ctx) {
  bool visible = action.payload ?? false;
  if (visible) {
    ctx.dispatch((DeviceMapBoxActionCreator.setDragFrontWidgetVisible(false)));
  } else {
    ctx.state.dragPageState?.currentState?.setMiddleHeight();
    ctx.dispatch((DeviceMapBoxActionCreator.changeTabDetailName(
        TabDetailPageEnum.Discovery)));
    ctx.dispatch((DeviceMapBoxActionCreator.setDragFrontWidgetVisible(true)));
  }

  return false;
}
