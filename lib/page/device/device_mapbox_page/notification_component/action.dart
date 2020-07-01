import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum NotificationAction { action }

class NotificationActionCreator {
  static Action onAction() {
    return const Action(NotificationAction.action);
  }
}
