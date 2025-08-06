import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationUtils {
  static Future<LatLng?> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

  static double hitungJarakMeter(
      double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }
}
