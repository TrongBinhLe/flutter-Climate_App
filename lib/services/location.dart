import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longtitude;

  Future<void> getPosition() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position);
      latitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
