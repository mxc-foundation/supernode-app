import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/map_box.dart';

import 'introduction_component/state.dart';

class DeviceMapBoxState implements Cloneable<DeviceMapBoxState> {
  MapViewController mapCtl = MapViewController();
  bool showIntroduction = true;
  String userGroupValue = 'Me';
  String genderGroupValue = 'Male';
  PageController pageController = new PageController();

  @override
  DeviceMapBoxState clone() {
    return DeviceMapBoxState()
      ..mapCtl = mapCtl
      ..showIntroduction = showIntroduction
      ..userGroupValue = userGroupValue
      ..genderGroupValue = genderGroupValue
      ..pageController = pageController;
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
      ..pageController = state.pageController;
  }

  @override
  void set(DeviceMapBoxState state, IntroductionState subState) {
    state.userGroupValue = subState.userGroupValue;
    state.genderGroupValue = subState.genderGroupValue;
    state.pageController = subState.pageController;
  }
}
