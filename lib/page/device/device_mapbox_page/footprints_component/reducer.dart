import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FootprintsState> buildReducer() {
  return asReducer(
    <Object, Reducer<FootprintsState>>{
      FootprintsAction.action: _onAction,
    },
  );
}

FootprintsState _onAction(FootprintsState state, Action action) {
  final FootprintsState newState = state.clone();
  return newState;
}
