import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SmartWatchDetailAction { action }

class SmartWatchDetailActionCreator {
  static Action onAction() {
    return const Action(SmartWatchDetailAction.action);
  }
}
