import 'package:dartz/dartz.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_source/data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<Either<Null, Profile>> getProfile() async {
    try {
      final profile = await dataSource.fetchProfile();
      return Right(profile);
    } catch (e) {
      return Left(null);
    }
  }

  @override
  Future<Either<Null, Profile>> updateProfile(Profile profile) async {
    try {
      final updatedProfile = await dataSource.updateProfile(profile);
      return Right(updatedProfile);
    } catch (e) {
      return Left(null);
    }
  }
}
