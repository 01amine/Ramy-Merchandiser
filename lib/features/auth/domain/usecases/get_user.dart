import 'package:dartz/dartz.dart';
import 'package:ramy/shared/utils/dep_inj.dart';

import '../repository/auth.dart';
import 'usecase.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {

  @override
  Future<Either> call({dynamic param}) async {
    return DepInj.sl<AuthRepository>().getUser();
  }
  
}