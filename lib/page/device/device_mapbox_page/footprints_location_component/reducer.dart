import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FootPrintsLocationState> buildReducer() {
  return asReducer(
    <Object, Reducer<FootPrintsLocationState>>{
      FootPrintsLocationAction.resetToDefault: _resetToDefault,
    },
  );
}

FootPrintsLocationState _resetToDefault(FootPrintsLocationState state, Action action) {
  final FootPrintsLocationState newState = state.clone();
  return newState;
}
