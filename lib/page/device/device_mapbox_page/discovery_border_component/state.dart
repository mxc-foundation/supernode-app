import 'package:fish_redux/fish_redux.dart';

class DiscoveryBorderState implements Cloneable<DiscoveryBorderState> {
  double gatewaySliderValue;

  @override
  DiscoveryBorderState clone() {
    return DiscoveryBorderState()..gatewaySliderValue = gatewaySliderValue;
  }
}

DiscoveryBorderState initState(Map<String, dynamic> args) {
  return DiscoveryBorderState();
}
