import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

// Events
abstract class MapEvent {}

class InitializeMap extends MapEvent {
  final double initialLatitude;
  final double initialLongitude;

  InitializeMap(this.initialLatitude, this.initialLongitude);
}

class UpdateLocation extends MapEvent {
  final double latitude;
  final double longitude;

  UpdateLocation(this.latitude, this.longitude);
}

class UpdateSellingPoints extends MapEvent {
  final List<SellingPoint> points;

  UpdateSellingPoints(this.points);
}

class OptimizeRoute extends MapEvent {}

// States
abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapUpdated extends MapState {
  final double currentLatitude;
  final double currentLongitude;
  final double initialLatitude;
  final double initialLongitude;
  final List<SellingPoint> sellingPoints;
  final List<LatLng> routePoints;
  final double totalDistance;
  final Duration estimatedTime;

  MapUpdated({
    required this.currentLatitude,
    required this.currentLongitude,
    required this.initialLatitude,
    required this.initialLongitude,
    required this.sellingPoints,
    required this.routePoints,
    this.totalDistance = 0,
    this.estimatedTime = Duration.zero,
  });
}

class MapError extends MapState {
  final String message;

  MapError(this.message);
}

// Model
class SellingPoint {
  final LatLng location;
  final String label;
  final int priority;

  SellingPoint(this.location, this.label, {this.priority = 0});
}

// BLOC
class MapBloc extends Bloc<MapEvent, MapState> {
  final RouteService _routeService;

  MapBloc(this._routeService) : super(MapInitial()) {
    on<InitializeMap>(_onInitializeMap);
    on<UpdateLocation>(_onUpdateLocation);
    on<UpdateSellingPoints>(_onUpdateSellingPoints);
    on<OptimizeRoute>(_onOptimizeRoute);
  }

  Future<void> _onInitializeMap(
    InitializeMap event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());
    try {
      emit(MapUpdated(
        currentLatitude: event.initialLatitude,
        currentLongitude: event.initialLongitude,
        initialLatitude: event.initialLatitude,
        initialLongitude: event.initialLongitude,
        sellingPoints: [],
        routePoints: [],
      ));
    } catch (e) {
      emit(MapError('Failed to initialize map: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateLocation(
    UpdateLocation event,
    Emitter<MapState> emit,
  ) async {
    if (state is! MapUpdated) return;
    
    final currentState = state as MapUpdated;
    
    emit(currentState.copyWith(
      currentLatitude: event.latitude,
      currentLongitude: event.longitude,
    ));
  }

  Future<void> _onUpdateSellingPoints(
    UpdateSellingPoints event,
    Emitter<MapState> emit,
  ) async {
    if (state is! MapUpdated) return;
    
    final currentState = state as MapUpdated;
    final optimizedPoints = await _optimizeRoute(event.points);
    
    emit(currentState.copyWith(
      sellingPoints: optimizedPoints,
    ));
  }

  Future<void> _onOptimizeRoute(
    OptimizeRoute event,
    Emitter<MapState> emit,
  ) async {
    if (state is! MapUpdated) return;
    
    final currentState = state as MapUpdated;
    emit(MapLoading());
    
    try {
      final optimizedRoute = await _routeService.calculateOptimalRoute(
        currentState.sellingPoints,
        currentState.currentLatitude,
        currentState.currentLongitude,
      );

      emit(currentState.copyWith(
        routePoints: optimizedRoute.routePoints,
        totalDistance: optimizedRoute.totalDistance,
        estimatedTime: optimizedRoute.estimatedTime,
      ));
    } catch (e) {
      emit(MapError('Route optimization failed: ${e.toString()}'));
    }
  }

  Future<List<SellingPoint>> _optimizeRoute(List<SellingPoint> points) async {
    // Simple optimization: sort by priority then latitude
    return List.from(points)
      ..sort((a, b) {
        if (a.priority != b.priority) {
          return b.priority.compareTo(a.priority);
        }
        return a.location.latitude.compareTo(b.location.latitude);
      });
  }
}

// Route Service Interface
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
      totalDistance: totalDistance ?? this.totalDistance,
      estimatedTime: estimatedTime ?? this.estimatedTime,
    );
  }
}