import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum NotificationOutAction { action }

class NotificationOutActionCreator {
  static Action onAction() {
    return const Action(NotificationOutAction.action);
  }
}
