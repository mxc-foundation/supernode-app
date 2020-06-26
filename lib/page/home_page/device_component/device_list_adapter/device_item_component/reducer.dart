import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DeviceItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<DeviceItemState>>{
      DeviceItemAction.action: _onAction,
    },
  );
}

DeviceItemState _onAction(DeviceItemState state, Action action) {
  final DeviceItemState newState = state.clone();
  return newState;
}
