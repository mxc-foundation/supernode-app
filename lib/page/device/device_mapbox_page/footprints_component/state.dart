import 'package:fish_redux/fish_redux.dart';

class FootprintsState implements Cloneable<FootprintsState> {

  @override
  FootprintsState clone() {
    return FootprintsState();
  }
}

FootprintsState initState(Map<String, dynamic> args) {
  return FootprintsState();
}
