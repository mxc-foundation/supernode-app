import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DiscoveryBorderState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscoveryBorderState>>{
      DiscoveryBorderAction.action: _onAction,
    },
  );
}

DiscoveryBorderState _onAction(DiscoveryBorderState state, Action action) {
  final DiscoveryBorderState newState = state.clone();
  return newState;
}
