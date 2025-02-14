import 'package:dartz/dartz.dart';

import '../../../../shared/utils/dep_inj.dart';
import '../repository/auth.dart';
import 'usecase.dart';

class LogoutUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({param}) async {
    return await DepInj.sl<AuthRepository>().logout();
  }
}
