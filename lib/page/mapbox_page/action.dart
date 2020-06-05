import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';

//TODO replace with your own action
enum mapboxAction {
  action,
  location,
}

class mapboxActionCreator {
  static Action onAction() {
    return const Action(mapboxAction.action);
  }

  static Action onLocation(LatLng location){
    return Action(mapboxAction.location, payload: location);
  }
}
