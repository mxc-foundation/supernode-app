import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/map_box.dart';

import 'introduction_component/state.dart';

class DeviceMapBoxState implements Cloneable<DeviceMapBoxState> {
  MapViewController mapCtl = MapViewController();
  bool showIntroduction=true;
  @override
  DeviceMapBoxState clone() {
    return DeviceMapBoxState()
      ..mapCtl = mapCtl
      ..showIntroduction=showIntroduction;
  }
}

DeviceMapBoxState initState(Map<String, dynamic> args) {
  return DeviceMapBoxState()
    ..mapCtl = MapViewController();
}
class IntroductionConnector extends ConnOp<DeviceMapBoxState, IntroductionState> {
  @override
  IntroductionState get(DeviceMapBoxState state) {
    return IntroductionState();
  }

  @override
  void set(DeviceMapBoxState state, IntroductionState subState) {}
}

