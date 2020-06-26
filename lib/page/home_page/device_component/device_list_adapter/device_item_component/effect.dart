import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DeviceItemState> buildEffect() {
  return combineEffects(<Object, Effect<DeviceItemState>>{
    DeviceItemAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DeviceItemState> ctx) {
}
