import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<FootprintsState> buildEffect() {
  return combineEffects(<Object, Effect<FootprintsState>>{
    FootprintsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<FootprintsState> ctx) {
}
