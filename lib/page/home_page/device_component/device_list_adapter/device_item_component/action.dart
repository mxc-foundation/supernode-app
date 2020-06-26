import 'package:fish_redux/fish_redux.dart';

enum DeviceItemAction { action }

class DeviceItemActionCreator {
  static Action onAction() {
    return const Action(DeviceItemAction.action);
  }
}
