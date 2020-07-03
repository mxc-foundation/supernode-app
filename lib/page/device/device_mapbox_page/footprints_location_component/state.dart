import 'package:fish_redux/fish_redux.dart';

class FootPrintsLocationState implements Cloneable<FootPrintsLocationState> {

  @override
  FootPrintsLocationState clone() {
    return FootPrintsLocationState();
  }
}

FootPrintsLocationState initState(Map<String, dynamic> args) {
  return FootPrintsLocationState();
}
