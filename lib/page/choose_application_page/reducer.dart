import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChooseApplicationState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChooseApplicationState>>{
      ChooseApplicationAction.action: _onAction,
    },
  );
}

ChooseApplicationState _onAction(ChooseApplicationState state, Action action) {
  final ChooseApplicationState newState = state.clone();
  return newState;
}
