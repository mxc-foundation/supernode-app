import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'state.dart';

Effect<DeviceMapBoxState> buildEffect() {
  return combineEffects(<Object, Effect<DeviceMapBoxState>>{
    DeviceMapBoxAction.introductionVisible: _introductionVisible,
  });
}
bool _introductionVisible(Action action, Context<DeviceMapBoxState> ctx) {
  ctx.state.dragPageState?.currentState?.setInitHeight();
  return false;
}

