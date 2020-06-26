import 'package:fish_redux/fish_redux.dart';

class DeviceItemState implements Cloneable<DeviceItemState> {

  @override
  DeviceItemState clone() {
    return DeviceItemState();
  }
}

DeviceItemState initState(Map<String, dynamic> args) {
  return DeviceItemState();
}
