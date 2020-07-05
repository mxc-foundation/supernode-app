import 'package:fish_redux/fish_redux.dart';

enum DeviceAction { onQrScan }

class DeviceActionCreator {
  static Action onQrScan() {
    return const Action(DeviceAction.onQrScan);
  }
}
