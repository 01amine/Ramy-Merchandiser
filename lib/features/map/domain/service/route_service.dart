import 'package:latlong2/latlong.dart';

import '../../presentation/bloc/map_bloc.dart';

abstract class RouteService {
  Future<OptimizedRoute> calculateOptimalRoute(
    List<SellingPoint> points,
    double startLat,
    double startLon,
  );
}

class OptimizedRoute {
  final List<LatLng> routePoints;
  final double totalDistance;
  final Duration estimatedTime;

  OptimizedRoute({
    required this.routePoints,
    required this.totalDistance,
    required this.estimatedTime,
  });
}

// Extension for copyWith
extension MapUpdatedCopyWith on MapUpdated {
  get initialLatitude => null;

  MapUpdated copyWith({
    double? currentLatitude,
    double? currentLongitude,
    List<SellingPoint>? sellingPoints,
    List<LatLng>? routePoints,
    double? totalDistance,
    Duration? estimatedTime,
  }) {
    return MapUpdated(
      currentLatitude: currentLatitude ?? this.currentLatitude,
      currentLongitude: currentLongitude ?? this.currentLongitude,
      initialLatitude: initialLatitude,
      initialLongitude: initialLongitude,
      sellingPoints: sellingPoints ?? this.sellingPoints,
      routePoints: routePoints ?? this.routePoints,
    );
  }
}