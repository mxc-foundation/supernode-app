import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'action.dart';
import 'state.dart';

Reducer<mapboxState> buildReducer() {
  return asReducer(
    <Object, Reducer<mapboxState>>{
      mapboxAction.action: _onAction,
      mapboxAction.location: _onLocation,
    },
  );
}

mapboxState _onAction(mapboxState state, Action action) {
  final mapboxState newState = state.clone();
  return newState;
}

mapboxState _onLocation(mapboxState state, Action action) {
  LatLng loc = action.payload;

  final mapboxState newState = state.clone();
  return newState..myLocation = loc;
}
