import 'package:ramy/shared/utils/dep_inj.dart';

import '../repository/auth.dart';
import 'usecase.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {

  @override
  Future<bool> call({dynamic param}) async {
    return DepInj.sl<AuthRepository>().isLoggedIn();
  }
  
}