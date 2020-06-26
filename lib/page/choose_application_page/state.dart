import 'package:fish_redux/fish_redux.dart';

class ChooseApplicationState implements Cloneable<ChooseApplicationState> {

  @override
  ChooseApplicationState clone() {
    return ChooseApplicationState();
  }
}

ChooseApplicationState initState(Map<String, dynamic> args) {
  return ChooseApplicationState();
}
