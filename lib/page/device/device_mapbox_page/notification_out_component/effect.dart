import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<NotificationOutState> buildEffect() {
  return combineEffects(<Object, Effect<NotificationOutState>>{
    NotificationOutAction.action: _onAction,
  });
}

void _onAction(Action action, Context<NotificationOutState> ctx) {
}
