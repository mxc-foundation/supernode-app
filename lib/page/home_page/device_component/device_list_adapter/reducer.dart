import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/device_component/state.dart';

import 'action.dart';

Reducer<DeviceState> buildReducer() {
  return asReducer(
    <Object, Reducer<DeviceState>>{
      DeviceListAction.action: _onAction,
    },
  );
}

DeviceState _onAction(DeviceState state, Action action) {
  final DeviceState newState = state.clone();
  return newState;
}
