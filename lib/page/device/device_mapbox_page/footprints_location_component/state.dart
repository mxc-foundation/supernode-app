import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/map_box.dart';

class FootPrintsLocationState implements Cloneable<FootPrintsLocationState> {
  MapViewController mapCtl;

  @override
  FootPrintsLocationState clone() {
    return FootPrintsLocationState()..mapCtl = mapCtl;
  }
}

FootPrintsLocationState initState(Map<String, dynamic> args) {
  return FootPrintsLocationState();
}
