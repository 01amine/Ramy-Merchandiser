import 'package:geolocator/geolocator.dart';

abstract class LocationDataSource {
  Future<Position> getCurrentPosition();
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    return await Geolocator.getCurrentPosition();
  }
}
