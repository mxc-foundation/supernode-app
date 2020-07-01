import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DeviceMapBoxState> buildReducer() {
  return asReducer(
    <Object, Reducer<DeviceMapBoxState>>{
      DeviceMapBoxAction.addMapController: _addMapController,
      DeviceMapBoxAction.introductionVisible: _introductionVisible,
      DeviceMapBoxAction.changeBottomTab: _changeBottomTab,
    },
  );
}

DeviceMapBoxState _addMapController(DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..mapCtl = action.payload;
}

DeviceMapBoxState _introductionVisible(DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..showIntroduction = action.payload;
}

DeviceMapBoxState _changeBottomTab(DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..selectTabIndex = action.payload;
}
