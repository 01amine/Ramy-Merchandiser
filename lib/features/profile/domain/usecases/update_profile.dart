
import '../../../auth/domain/usecases/usecase.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile implements UseCase<Profile, Profile> {
  final ProfileRepository repository;

  UpdateProfile(this.repository);
  
  @override
  Future<Profile> call({Profile? param}) {
    // TODO: implement call
    throw UnimplementedError();
  }

  
}
