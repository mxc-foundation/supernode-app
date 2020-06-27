import 'package:fish_redux/fish_redux.dart';

class SmartWatchDetailState implements Cloneable<SmartWatchDetailState> {

  @override
  SmartWatchDetailState clone() {
    return SmartWatchDetailState();
  }
}

SmartWatchDetailState initState(Map<String, dynamic> args) {
  return SmartWatchDetailState();
}
