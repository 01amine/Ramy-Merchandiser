import 'package:latlong2/latlong.dart';

class SellingPoint {
  final LatLng location;
  final String label;
  final int priority;

  SellingPoint(this.location, this.label, {this.priority = 0});
}