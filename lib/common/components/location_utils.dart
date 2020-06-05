import 'package:location/location.dart';

class LocationUtils {
  factory LocationUtils() => instance;

  LocationUtils._();

  static final LocationUtils instance = LocationUtils._();

  static Location location =  Location();
  static bool _serviceEnabled;
  static PermissionStatus _permissionGranted;
  static LocationData _locationData;

  static LocationData get locationData=> _locationData;

  static Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }
    _locationData = await location.getLocation();
  }

}
