import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IntroductionState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntroductionState>>{
      IntroductionAction.action: _onAction,
    },
  );
}

IntroductionState _onAction(IntroductionState state, Action action) {
  final IntroductionState newState = state.clone();
  return newState;
}
