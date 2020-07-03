import 'package:fish_redux/fish_redux.dart';

class DiscoveryBorderState implements Cloneable<DiscoveryBorderState> {

  @override
  DiscoveryBorderState clone() {
    return DiscoveryBorderState();
  }
}

DiscoveryBorderState initState(Map<String, dynamic> args) {
  return DiscoveryBorderState();
}
