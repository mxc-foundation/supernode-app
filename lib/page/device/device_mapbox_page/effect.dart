import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'state.dart';

Effect<DeviceMapBoxState> buildEffect() {
  return combineEffects(<Object, Effect<DeviceMapBoxState>>{
    DeviceMapBoxAction.introductionVisible: _introductionVisible,
    DeviceMapBoxAction.setBorderPromptVisible: _setBorderPromptVisible,
    DeviceMapBoxAction.changeTabDetailName: _changeTabDetailName,
    DeviceMapBoxAction.onMapBoxTap: _onMapBoxTap,
    DeviceMapBoxAction.changeBottomTab: _changeBottomTab,
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<DeviceMapBoxState> ctx) {
  Future.delayed(Duration(seconds: 2), () {
    _setButtonTabMap(0, ctx);
  });
}

bool _changeBottomTab(Action action, Context<DeviceMapBoxState> ctx) {
  var _selectIndex = action.payload;
  _setButtonTabMap(_selectIndex, ctx);
  return false;
}

void _onMapBoxTap(Action action, Context<DeviceMapBoxState> ctx) {
  if (ctx.state.showTabDetailName == null) {
    ctx?.state?.dragPageState?.currentState?.setMinHeight();
  }

  var point = action.payload;
  if (ctx.state.showTabDetailName == TabDetailPageEnum.Footprints) {
    ctx.state.mapCtl.removeAll();
    ctx.state.mapCtl.addCircle(
      CircleOptions(
        geometry: point,
        circleColor: "#FF0000",
        circleRadius: 5,
      ),
    );
    ctx.state.mapCtl.addSymbol(
      MapMarker(
        size: 2,
        image: 'assets/images/device/PIN.png',
        point: point,
        iconOffset: Offset(0, -10),
      ),
    );
  }
}

bool _changeTabDetailName(Action action, Context<DeviceMapBoxState> ctx) {
  ctx.state.dragPageState?.currentState?.setMiddleHeight();
  TabDetailPageEnum tabEnum = action.payload;
  if (tabEnum == null) {
    _setButtonTabMap(ctx.state.selectTabIndex, ctx);
  } else {
    _setButtonTabDetailMap(tabEnum, ctx);
  }

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

void _setButtonTabMap(int _selectIndex, Context<DeviceMapBoxState> ctx) {
  var center = ctx.state.centerPoint;
  ctx.state.mapCtl.removeAll();
  if ((ctx.state?.mapCtl?.markerCircleOptions?.length ?? 0) == 0) {
    if (_selectIndex == 0) {
      ctx.state.mapCtl.addSymbol(
        MapMarker(
          size: 1,
          image: 'assets/images/device/gatwary_location.png',
          point: center,
        ),
      );
      ctx.state.mapCtl.addSymbol(
        MapMarker(
          size: 1,
          image: 'assets/images/device/watch_location.png',
          point: LatLng(
            center.latitude + sin(1 * pi / 6.0) / 100.0,
            center.longitude + cos(1 * pi / 6.0) / 100.0,
          ),
        ),
      );
    } else if (_selectIndex == 1) {
      ctx.state.mapCtl.addSymbol(
        MapMarker(
          size: 1,
          image: 'assets/images/device/gatwary_location.png',
          point: center,
        ),
      );
      List.generate(6, (index) {
        ctx.state.mapCtl.addCircle(
          CircleOptions(
            geometry: LatLng(
              center.latitude + sin((index + 1) * pi / 6.0) / 100.0,
              center.longitude + cos((index + 1) * pi / 6.0) / 100.0,
            ),
            circleColor: "#FF0000",
            circleRadius: 5,
          ),
        );
        ctx.state.mapCtl.addCircle(
          CircleOptions(
            geometry: LatLng(
              center.latitude + sin((index + 3) * pi / 6.0) / 80.0,
              center.longitude + cos((index + 3) * pi / 6.0) / 80.0,
            ),
            circleColor: "#10C469",
            circleRadius: 5,
          ),
        );
      });
    } else if (_selectIndex == 2) {
      ctx.state.mapCtl.addSymbol(
        MapMarker(
          size: 1,
          image: 'assets/images/device/gatwary_location.png',
          point: center,
          withCircle: true,
          circleOptions: CircleOptions(
            geometry: center,
            circleColor: "#FF0000",
            circleRadius: 100,
            circleOpacity: 0.1,
          ),
        ),
      );
      List.generate(6, (index) {
        ctx.state.mapCtl.addSymbol(
          MapMarker(
            size: 1,
            image: 'assets/images/device/notification_location.png',
            point: LatLng(
              center.latitude + sin((index + 1) * pi / 6.0) / 50.0,
              center.longitude + cos((index + 1) * pi / 6.0) / 50.0,
            ),
          ),
        );
      });
    }
  }
}

void _setButtonTabDetailMap(
    TabDetailPageEnum tabEnum, Context<DeviceMapBoxState> ctx) {
  var center = ctx.state.centerPoint;
  ctx.state.mapCtl.removeAll();
  if ((ctx.state?.mapCtl?.markerCircleOptions?.length ?? 0) == 0) {
    if (tabEnum == TabDetailPageEnum.Discovery) {
      ctx.state.mapCtl.addSymbol(
        MapMarker(
          size: 1,
          image: 'assets/images/device/gatwary_location.png',
          point: center,
          withCircle: true,
          circleOptions: CircleOptions(
            geometry: center,
            circleColor: "#FF0000",
            circleRadius: 100,
            circleOpacity: 0.1,
          ),
        ),
      );
      ctx.state.mapCtl.addSymbol(
        MapMarker(
          size: 1,
          image: 'assets/images/device/watch_location.png',
          point: LatLng(
            center.latitude + sin(1 * pi / 6.0) / 100.0,
            center.longitude + cos(1 * pi / 6.0) / 100.0,
          ),
        ),
      );
    } else if (tabEnum == TabDetailPageEnum.Footprints) {
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
    } else if (tabEnum == TabDetailPageEnum.Notification) {
      ctx.state.mapCtl.addSymbol(
        MapMarker(
          size: 1,
          image: 'assets/images/device/gatwary_location.png',
          point: center,
          withCircle: true,
          circleOptions: CircleOptions(
            geometry: center,
            circleColor: "#FF0000",
            circleRadius: 100,
            circleOpacity: 0.1,
          ),
        ),
      );
      ctx.state.mapCtl.addSymbol(
        MapMarker(
          size: 1,
          image: 'assets/images/device/notification_location.png',
          point: LatLng(
            center.latitude + sin(1 * pi / 6.0) / 50.0,
            center.longitude + cos(1 * pi / 6.0) / 50.0,
          ),
        ),
      );
    }
  }
}
