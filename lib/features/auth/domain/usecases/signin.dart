import 'package:dartz/dartz.dart';
import 'package:ramy/shared/utils/dep_inj.dart';

import '../../data/models/signin_req_params.dart';
import '../repository/auth.dart';
import 'usecase.dart';

class SigninUseCase implements UseCase<Either, SigninReqParams> {

  @override
  Future<Either> call({SigninReqParams ? param}) async {
    return DepInj.sl<AuthRepository>().signin(param!);
  }
  
}