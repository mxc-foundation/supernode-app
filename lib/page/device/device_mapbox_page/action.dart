import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'state.dart';

enum DeviceMapBoxAction {
  addMapController,
  setDragFrontWidgetVisible,
  introductionVisible,
  changeBottomTab,
  setBorderPromptVisible,
  changeTabDetailName,
  changeGatewaySliderValue,
  onMapBoxTap,
}

class DeviceMapBoxActionCreator {

  static Action onMapBoxTap(LatLng coordinates) {
    return Action(DeviceMapBoxAction.onMapBoxTap, payload: coordinates);
  }

  static Action changeGatewaySliderValue(double value) {
    return Action(DeviceMapBoxAction.changeGatewaySliderValue, payload: value);
  }

  static Action changeTabDetailName(TabDetailPageEnum detailPageEnum) {
    return Action(DeviceMapBoxAction.changeTabDetailName,
        payload: detailPageEnum);
  }

  static Action addMapController(MapboxMapController ctl) {
    return Action(DeviceMapBoxAction.addMapController, payload: ctl);
  }

  static Action introductionVisible(bool visible) {
    return Action(DeviceMapBoxAction.introductionVisible, payload: visible);
  }

  static Action changeBottomTab(int selectIndex) {
    return Action(DeviceMapBoxAction.changeBottomTab, payload: selectIndex);
  }

  static Action setBorderPromptVisible(bool visible) {
    return Action(DeviceMapBoxAction.setBorderPromptVisible, payload: visible);
  }

  static Action setDragFrontWidgetVisible(bool visible) {
    return Action(DeviceMapBoxAction.setDragFrontWidgetVisible,
        payload: visible);
  }
}
