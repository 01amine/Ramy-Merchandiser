
import 'package:dartz/dartz.dart';
import 'package:ramy/shared/utils/dep_inj.dart';
import 'package:ramy/shared/utils/dio_helper.dart';
import 'package:ramy/shared/utils/persist_data.dart';


import '../models/signin_req_params.dart';
import '../models/signup_req_params.dart';

abstract class AuthApiService {
  AuthApiService(Dio dio);


  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> getUser();
  Future<Either> signin(SigninReqParams signinReq);
} 

class AuthApiServiceImpl extends AuthApiService {
  AuthApiServiceImpl(super.dio);

  

  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {

     var response = await DepInj.sl<DioHelper>().post(
        ApiUrls.register,
        data: signupReq.toMap(),
        body: '', headers: {}
      );

      return Right(response);

    } on DioException catch(e) {
      return Left(e.response!.data['message']);
    }
  }
  
  @override
  Future<Either> getUser() async {
    
    try {
       var token = PersistData.getToken();
       var response = await DepInj.sl<DioHelper>().get(
        ApiUrls.userProfile,
        options: Options(
          headers: {
            'Authorization' : 'Bearer $token '
          }
        )
      );

      return Right(response);

    } on DioException catch(e) {
      return Left(e.response!.data['message']);
    }
  }
  
  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    try {

     var response = await DepInj.sl<DioHelper>().post(
        ApiUrls.login,
        data: signinReq.toMap(), body: '', headers: {}
      );

      return Right(response);

    } on DioException catch(e) {
      return Left(e.response!.data['message']);
    }
  }
  
}

class ApiUrls {
  static var login;
  
  static var userProfile;
  
  static var register;
}