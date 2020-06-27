import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SmartWatchDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<SmartWatchDetailState>>{
      SmartWatchDetailAction.action: _onAction,
    },
  );
}

SmartWatchDetailState _onAction(SmartWatchDetailState state, Action action) {
  final SmartWatchDetailState newState = state.clone();
  return newState;
}
