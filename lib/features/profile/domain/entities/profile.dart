import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String name;
  final String email;
  final String profilePictureUrl;

  const Profile({
    required this.name,
    required this.email,
    required this.profilePictureUrl,
  });

  Profile copyWith({String? name, String? email, String? profilePictureUrl}) {
    return Profile(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  @override
  List<Object?> get props => [name, email, profilePictureUrl];
}
