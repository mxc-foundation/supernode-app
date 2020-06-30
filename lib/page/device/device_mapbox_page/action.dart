import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

enum DeviceMapBoxAction { addMapController, introductionVisible }

class DeviceMapBoxActionCreator {
  static Action addMapController(MapboxMapController ctl) {
    return Action(DeviceMapBoxAction.addMapController, payload: ctl);
  }

  static Action introductionVisible(bool visible) {
    return Action(DeviceMapBoxAction.introductionVisible, payload: visible);
  }
}
