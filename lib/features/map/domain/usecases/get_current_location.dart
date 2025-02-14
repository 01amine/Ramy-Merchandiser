import '../../../auth/domain/usecases/usecase.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';

class GetCurrentLocation implements UseCase<Location, NoParams> {
  final LocationRepository repository;

  GetCurrentLocation(this.repository);
  
  @override
  Future<Location> call({NoParams? param}) {
    // TODO: implement call
    throw UnimplementedError();
  }
  
  

}

class NoParams {
}
