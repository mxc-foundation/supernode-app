import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<BorderPromptState> buildEffect() {
  return combineEffects(<Object, Effect<BorderPromptState>>{
    BorderPromptAction.action: _onAction,
  });
}

void _onAction(Action action, Context<BorderPromptState> ctx) {
}
