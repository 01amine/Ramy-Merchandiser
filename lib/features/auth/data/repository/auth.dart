import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ramy/shared/utils/dep_inj.dart';
import 'package:ramy/shared/utils/persist_data.dart';

import '../../domain/repository/auth.dart';
import '../models/signin_req_params.dart';
import '../models/signup_req_params.dart';
import '../models/user.dart';
import '../source/auth_api_service.dart';
import '../source/auth_local_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    Either result = await DepInj.sl<AuthApiService>().signup(signupReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      PersistData.writeData('token', response.data['token']);
      return Right(response);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await DepInj.sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> getUser() async {
    Either result = await DepInj.sl<AuthApiService>().getUser();
    return result.fold((error) {
      return Left(error);
    }, (data) {
      Response response = data;
      var userModel = UserModel.fromMap(response.data);
      var userEntity = userModel.toEntity();
      return Right(userEntity);
    });
  }

  @override
  Future<Either> logout() async {
    return await DepInj.sl<AuthLocalService>().logout();
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    Either result = await DepInj.sl<AuthApiService>().signin(signinReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      PersistData.writeData('token', response.data['token']);
      return Right(response);
    });
  }
}
