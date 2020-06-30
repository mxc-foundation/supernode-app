import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<IntroductionState> buildEffect() {
  return combineEffects(<Object, Effect<IntroductionState>>{
    IntroductionAction.action: _onAction,
  });
}

void _onAction(Action action, Context<IntroductionState> ctx) {
}
