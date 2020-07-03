import 'package:fish_redux/fish_redux.dart';

class NotificationOutState implements Cloneable<NotificationOutState> {

  @override
  NotificationOutState clone() {
    return NotificationOutState();
  }
}

NotificationOutState initState(Map<String, dynamic> args) {
  return NotificationOutState();
}
