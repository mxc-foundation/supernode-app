import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SmartWatchDetailState> buildEffect() {
  return combineEffects(<Object, Effect<SmartWatchDetailState>>{
    SmartWatchDetailAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SmartWatchDetailState> ctx) {
}
