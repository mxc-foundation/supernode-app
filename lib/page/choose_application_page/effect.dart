import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ChooseApplicationState> buildEffect() {
  return combineEffects(<Object, Effect<ChooseApplicationState>>{
    ChooseApplicationAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ChooseApplicationState> ctx) {
}
