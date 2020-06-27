import 'package:fish_redux/fish_redux.dart';

enum DeviceAction { action }

class DeviceActionCreator {
  static Action onAction() {
    return const Action(DeviceAction.action);
  }
}
