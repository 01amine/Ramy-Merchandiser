import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ramy/shared/utils/persist_data.dart';

import '../../features/auth/data/repository/auth.dart';
import '../../features/auth/data/source/auth_api_service.dart';
import '../../features/auth/data/source/auth_local_service.dart';
import '../../features/auth/domain/repository/auth.dart';
import '../../features/map/data/datasource/location_data_source.dart';
import '../../features/map/data/repository/location_repository_impl.dart';
import '../../features/map/domain/repositories/location_repository.dart';
import '../../features/map/domain/usecases/get_current_location.dart';
import '../../features/scan/data/repositories/san_repository_impl.dart';
import '../../features/scan/domain/repository/scan_repository.dart';
import '../../features/scan/domain/use_case/perform_scan.dart';
import '../../features/scan/presentation/bloc/scan/scan_bloc.dart';

class DepInj {
  static final GetIt sl = GetIt.instance;

  static Future<void> init() async {
    // Dio instance
    sl.registerLazySingleton<Dio>(() => Dio());

    // Secure storage
    sl.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage());

    // API service
    sl.registerLazySingleton<AuthApiService>(
      () => AuthApiServiceImpl(sl<Dio>()),
    );

    // Local storage service
    sl.registerLazySingleton<AuthLocalService>(
      () => AuthLocalServiceImpl(sl<FlutterSecureStorage>()),
    );

    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(),
    );

    sl.registerLazySingleton<PersistData>(() => PersistData());

    sl.registerLazySingleton<LocationRepository>(
        () => LocationRepositoryImpl(LocationDataSourceImpl()));
    sl.registerLazySingleton(() => GetCurrentLocation(sl()));
    sl.registerLazySingleton<ScanRepository>(() => ScanRepositoryImpl());

    // Use Cases
    sl.registerLazySingleton(() => PerformScan(sl()));

    // BLoCs
    sl.registerFactory(() => ScanBloc(sl()));
  }
}
