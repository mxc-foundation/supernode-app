import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'state.dart';

Effect<DeviceMapBoxState> buildEffect() {
  return combineEffects(<Object, Effect<DeviceMapBoxState>>{
    DeviceMapBoxAction.introductionVisible: _introductionVisible,
    DeviceMapBoxAction.setBorderPromptVisible: _setBorderPromptVisible,
    DeviceMapBoxAction.changeTabDetailName: _changeTabDetailName,
  });
}

bool _changeTabDetailName(Action action, Context<DeviceMapBoxState> ctx) {
  ctx.state.dragPageState?.currentState?.setInitHeight();
  return false;
}

bool _introductionVisible(Action action, Context<DeviceMapBoxState> ctx) {
  bool visible = action.payload ?? false;
  if (!visible) {
    ctx.state.dragPageState?.currentState?.setInitHeight();
    ctx.dispatch((DeviceMapBoxActionCreator.setDragFrontWidgetVisible(true)));
  }
  return false;
}

bool _setBorderPromptVisible(Action action, Context<DeviceMapBoxState> ctx) {
  bool visible = action.payload ?? false;
  if (visible) {
    ctx.dispatch((DeviceMapBoxActionCreator.setDragFrontWidgetVisible(false)));
  } else {
    ctx.state.dragPageState?.currentState?.setInitHeight();
    ctx.dispatch((DeviceMapBoxActionCreator.changeTabDetailName(
        TabDetailPageEnum.Discovery)));
    ctx.dispatch((DeviceMapBoxActionCreator.setDragFrontWidgetVisible(true)));
  }

  return false;
}
