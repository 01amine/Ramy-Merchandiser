import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ramy/shared/utils/persist_data.dart';

abstract class AuthLocalService {
  AuthLocalService(FlutterSecureStorage flutterSecureStorage);

  Future<bool> isLoggedIn();
  Future<Either> logout();
} 


class AuthLocalServiceImpl extends AuthLocalService {
  AuthLocalServiceImpl(super.flutterSecureStorage);



  @override
  Future<bool> isLoggedIn() async {
    var token = PersistData.getToken();
    // ignore: unnecessary_null_comparison
    if (token  == null ){
      return false;
    } else {
      return true;
    }
  }
  
  @override
  Future<Either> logout() async {
    PersistData.deleteDataByKey('token');
    return const Right(true);
  }
  
}
