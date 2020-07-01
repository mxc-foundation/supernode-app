import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<NotificationState> buildEffect() {
  return combineEffects(<Object, Effect<NotificationState>>{
    NotificationAction.action: _onAction,
  });
}

void _onAction(Action action, Context<NotificationState> ctx) {
}
