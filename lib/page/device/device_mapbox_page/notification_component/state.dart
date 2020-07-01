import 'package:fish_redux/fish_redux.dart';

class NotificationState implements Cloneable<NotificationState> {

  @override
  NotificationState clone() {
    return NotificationState();
  }
}

NotificationState initState(Map<String, dynamic> args) {
  return NotificationState();
}
