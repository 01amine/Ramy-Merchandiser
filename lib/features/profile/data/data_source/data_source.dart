import 'dart:async';
import '../../domain/entities/profile.dart';

abstract class ProfileDataSource {
  Future<Profile> fetchProfile();
  Future<Profile> updateProfile(Profile profile);
}

class ProfileDataSourceImpl implements ProfileDataSource {
  @override
  Future<Profile> fetchProfile() async {
    // Simulate network latency
    await Future.delayed(Duration(seconds: 1));
    return Profile(
      name: 'Al arbi',
      email: 'arbie@gmail.com',
      profilePictureUrl: 'https://via.placeholder.com/150',
    );
  }

  @override
  Future<Profile> updateProfile(Profile profile) async {
    await Future.delayed(Duration(seconds: 1));

    return profile;
  }
}
