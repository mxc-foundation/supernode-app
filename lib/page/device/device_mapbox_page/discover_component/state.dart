import 'package:fish_redux/fish_redux.dart';

class DiscoverState implements Cloneable<DiscoverState> {

  @override
  DiscoverState clone() {
    return DiscoverState();
  }
}

DiscoverState initState(Map<String, dynamic> args) {
  return DiscoverState();
}
