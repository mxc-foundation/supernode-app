import 'package:fish_redux/fish_redux.dart';

enum DeviceListAction { action }

class DeviceAdapterActionCreator {
  static Action onAction() {
    return const Action(DeviceListAction.action);
  }
}
