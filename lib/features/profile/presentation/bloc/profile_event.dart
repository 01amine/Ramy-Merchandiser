import 'package:equatable/equatable.dart';
import '../../domain/entities/profile.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final Profile profile;

  const UpdateProfileEvent(this.profile);

  @override
  List<Object?> get props => [profile];
}
