import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/page/drag_page.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/discover_component/state.dart';

import 'footprints_component/state.dart';
import 'introduction_component/state.dart';
import 'notification_component/state.dart';

class DeviceMapBoxState implements Cloneable<DeviceMapBoxState> {
  MapViewController mapCtl = MapViewController();
  bool showIntroduction = true;
  String userGroupValue = 'Me';
  String genderGroupValue = 'Male';
  PageController introPageController = new PageController();
  PageController bottomPageController = new PageController();
  TabController bottomTabController;
  int selectTabIndex = 0;
  GlobalKey<DragPageState> dragPageState = new GlobalKey();

  @override
  DeviceMapBoxState clone() {
    return DeviceMapBoxState()
      ..mapCtl = mapCtl
      ..showIntroduction = showIntroduction
      ..userGroupValue = userGroupValue
      ..genderGroupValue = genderGroupValue
      ..introPageController = introPageController
      ..bottomPageController = bottomPageController
      ..selectTabIndex = selectTabIndex
      ..dragPageState = dragPageState;
  }
}

DeviceMapBoxState initState(Map<String, dynamic> args) {
  return DeviceMapBoxState()..mapCtl = MapViewController();
}

class IntroductionConnector
    extends ConnOp<DeviceMapBoxState, IntroductionState> {
  @override
  IntroductionState get(DeviceMapBoxState state) {
    return IntroductionState()
      ..userGroupValue = state.userGroupValue
      ..genderGroupValue = state.genderGroupValue
      ..pageController = state.introPageController;
  }

  @override
  void set(DeviceMapBoxState state, IntroductionState subState) {
    state.userGroupValue = subState.userGroupValue;
    state.genderGroupValue = subState.genderGroupValue;
    state.introPageController = subState.pageController;
  }
}

class DiscoverConnector extends ConnOp<DeviceMapBoxState, DiscoverState> {
  @override
  DiscoverState get(DeviceMapBoxState state) {
    return DiscoverState();
  }

  @override
  void set(DeviceMapBoxState state, DiscoverState subState) {}
}

class FootprintsConnector extends ConnOp<DeviceMapBoxState, FootprintsState> {
  @override
  FootprintsState get(DeviceMapBoxState state) {
    return FootprintsState();
  }

  @override
  void set(DeviceMapBoxState state, FootprintsState subState) {}
}

class NotificationConnector
    extends ConnOp<DeviceMapBoxState, NotificationState> {
  @override
  NotificationState get(DeviceMapBoxState state) {
    return NotificationState();
  }

  @override
  void set(DeviceMapBoxState state, NotificationState subState) {}
}
