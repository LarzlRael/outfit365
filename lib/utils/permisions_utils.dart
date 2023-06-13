part of 'utils.dart';

void accesoGPS(PermissionStatus status) {
  switch (status) {
    case PermissionStatus.granted:
      /* Navigator.pushReplacementNamed(context, 'mapa'); */
      break;

    case PermissionStatus.denied:
    case PermissionStatus.restricted:
    case PermissionStatus.limited:
    case PermissionStatus.permanentlyDenied:
      openAppSettings();
      break;
  }
}

Future<LatLng> getLocation() async {
  LocationPermission permission;
  permission = await Geolocator.requestPermission();

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  double lat = position.latitude;
  double long = position.longitude;

  return LatLng(lat, long);
}
