
import '../../../auth/domain/usecases/usecase.dart';
import '../../../map/domain/usecases/get_current_location.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetProfile implements UseCase<Profile, NoParams> {
  final ProfileRepository repository;

  GetProfile(this.repository);
  
  @override
  Future<Profile> call({NoParams? param}) {
    // TODO: implement call
    throw UnimplementedError();
  }

  
}
