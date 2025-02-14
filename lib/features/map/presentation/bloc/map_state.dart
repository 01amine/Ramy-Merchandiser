

import 'package:equatable/equatable.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapUpdated extends MapState {
  final double latitude;
  final double longitude;

  const MapUpdated(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}