import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DeviceMapBoxState> buildReducer() {
  return asReducer(
    <Object, Reducer<DeviceMapBoxState>>{
      DeviceMapBoxAction.addMapController: _addMapController,
    },
  );
}

DeviceMapBoxState _addMapController(DeviceMapBoxState state, Action action) {
  final DeviceMapBoxState newState = state.clone();
  return newState..mapCtl = action.payload;
}
