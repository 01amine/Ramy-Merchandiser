import 'package:equatable/equatable.dart';


abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class UpdateLocationEvent extends MapEvent {
  final double latitude;
  final double longitude;

  const UpdateLocationEvent(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}