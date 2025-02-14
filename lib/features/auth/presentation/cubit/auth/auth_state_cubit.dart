import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramy/shared/utils/dep_inj.dart';

import '../../../domain/usecases/is_logged_in.dart';
import 'auth_state.dart';

class AuthStateCubit extends Cubit<AuthState> {

  AuthStateCubit() : super(AppInitialState());
  
  void appStarted() async {
    var isLoggedIn = await DepInj.sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

}