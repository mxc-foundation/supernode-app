import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BorderPromptState> buildReducer() {
  return asReducer(
    <Object, Reducer<BorderPromptState>>{
      BorderPromptAction.action: _onAction,
    },
  );
}

BorderPromptState _onAction(BorderPromptState state, Action action) {
  final BorderPromptState newState = state.clone();
  return newState;
}
