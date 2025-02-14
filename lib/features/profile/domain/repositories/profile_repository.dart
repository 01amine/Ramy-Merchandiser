import 'package:dartz/dartz.dart';
import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Null, Profile>> getProfile();
  Future<Either<Null, Profile>> updateProfile(Profile profile);
}
