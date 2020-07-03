import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DiscoveryBorderState> buildEffect() {
  return combineEffects(<Object, Effect<DiscoveryBorderState>>{
    DiscoveryBorderAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DiscoveryBorderState> ctx) {
}
