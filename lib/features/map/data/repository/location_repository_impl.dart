import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasource/location_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Either<Null, Location>> getCurrentLocation() async {
    try {
      Position position = await dataSource.getCurrentPosition();
      return Right(Location(latitude: position.latitude, longitude: position.longitude));
    } catch (e) {
      return Left(null);
    }
  }
}