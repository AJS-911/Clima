import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Location();

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission!= LocationPermission.denied) {
          // Get location after permission granted
          Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
          latitude = position.latitude;
          longitude = position.longitude;
        } else {
          print('Location permission denied');
        }
      } else if (permission == LocationPermission.deniedForever) {
        // Permission denied permanently, handle appropriately
        print('Location permission denied forever');
      } else {
        // Permission already granted, get location
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
        latitude = position.latitude;
        longitude = position.longitude;
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

}