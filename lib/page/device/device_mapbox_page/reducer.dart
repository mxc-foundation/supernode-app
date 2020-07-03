import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DeviceMapBoxState> buildReducer() {
  return asReducer(
    <Object, Reducer<DeviceMapBoxState>>{
      DeviceMapBoxAction.addMapController: _addMapController,
      DeviceMapBoxAction.introductionVisible: _introductionVisible,
      DeviceMapBoxAction.changeBottomTab: _changeBottomTab,
      DeviceMapBoxAction.setBorderPromptVisible: _setBorderPromptVisible,
      DeviceMapBoxAction.setDragFrontWidgetVisible: _setDragFrontWidgetVisible,
      DeviceMapBoxAction.changeTabDetailName: _changeShowTabDetailName,
      DeviceMapBoxAction.changeGatewaySliderValue: _changeGatewaySliderValue,
    },
  );
}

DeviceMapBoxState _changeGatewaySliderValue(
    DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..gatewaySliderValue = action.payload;
}

DeviceMapBoxState _changeShowTabDetailName(
    DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..showTabDetailName = action.payload;
}

DeviceMapBoxState _addMapController(DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..mapCtl = action.payload;
}

DeviceMapBoxState _introductionVisible(DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..showIntroduction = action.payload;
}

DeviceMapBoxState _setBorderPromptVisible(
    DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..showSetBorderPrompt = action.payload;
}

DeviceMapBoxState _changeBottomTab(DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..selectTabIndex = action.payload;
}

DeviceMapBoxState _setDragFrontWidgetVisible(
    DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..showDragFrontWidget = action.payload;
}
