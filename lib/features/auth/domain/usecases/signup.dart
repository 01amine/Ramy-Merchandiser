import 'package:dartz/dartz.dart';
import 'package:ramy/shared/utils/dep_inj.dart';

import '../../data/models/signup_req_params.dart';
import '../repository/auth.dart';
import 'usecase.dart';

class SignupUseCase implements UseCase<Either, SignupReqParams> {

  @override
  Future<Either> call({SignupReqParams ? param}) async {
    return DepInj.sl<AuthRepository>().signup(param!);
  }
  
}