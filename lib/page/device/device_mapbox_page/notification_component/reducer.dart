import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NotificationState> buildReducer() {
  return asReducer(
    <Object, Reducer<NotificationState>>{
      NotificationAction.action: _onAction,
    },
  );
}

NotificationState _onAction(NotificationState state, Action action) {
  final NotificationState newState = state.clone();
  return newState;
}
