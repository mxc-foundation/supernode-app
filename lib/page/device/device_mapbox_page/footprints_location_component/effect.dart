import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<FootPrintsLocationState> buildEffect() {
  return combineEffects(<Object, Effect<FootPrintsLocationState>>{
    FootPrintsLocationAction.action: _onAction,
  });
}

void _onAction(Action action, Context<FootPrintsLocationState> ctx) {
}
