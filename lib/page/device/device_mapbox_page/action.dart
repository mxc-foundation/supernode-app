import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

enum DeviceMapBoxAction { addMapController }

class DeviceMapBoxActionCreator {
  static Action addMapController(MapboxMapController ctl) {
    return Action(DeviceMapBoxAction.addMapController, payload: ctl);
  }
}
