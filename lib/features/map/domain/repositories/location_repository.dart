import 'package:dartz/dartz.dart';
import '../entities/location.dart';

abstract class LocationRepository {
  Future<Either<Null, Location>> getCurrentLocation();
}
