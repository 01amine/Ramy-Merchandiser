import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../map/domain/usecases/get_current_location.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;

  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
  }) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      final result = await getProfile.call(param: NoParams());
      emit(ProfileLoaded(result));
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      final result = await updateProfile.call(param: event.profile);
      emit(ProfileLoaded(result));
    });
  }
}
