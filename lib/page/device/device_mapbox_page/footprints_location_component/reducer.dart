import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FootPrintsLocationState> buildReducer() {
  return asReducer(
    <Object, Reducer<FootPrintsLocationState>>{
      FootPrintsLocationAction.action: _onAction,
    },
  );
}

FootPrintsLocationState _onAction(FootPrintsLocationState state, Action action) {
  final FootPrintsLocationState newState = state.clone();
  return newState;
}
