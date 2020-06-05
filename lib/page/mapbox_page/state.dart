import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class mapboxState implements Cloneable<mapboxState> {
  List<Marker> gatewaysLocations;
  LatLng myLocation;
  MapController mapCtl = MapController();

  @override
  mapboxState clone() {
    return mapboxState()
      ..gatewaysLocations = gatewaysLocations
      ..myLocation = myLocation
      ..mapCtl = mapCtl;
  }
}

mapboxState initState(Map<String, dynamic> args) {
  return mapboxState()..gatewaysLocations = args['markers'] ?? [];
}
