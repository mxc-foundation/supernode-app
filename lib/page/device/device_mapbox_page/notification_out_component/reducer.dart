import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NotificationOutState> buildReducer() {
  return asReducer(
    <Object, Reducer<NotificationOutState>>{
      NotificationOutAction.action: _onAction,
    },
  );
}

NotificationOutState _onAction(NotificationOutState state, Action action) {
  final NotificationOutState newState = state.clone();
  return newState;
}
