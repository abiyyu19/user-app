import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/data/data.dart';
import 'package:userapp/domain/domain.dart';

final getIt = GetIt.instance;

void injection() {
  log('app flavor: $appFlavor', name: 'InjectionContainer');

  getIt
    ..registerSingleton<Dio>(
      Dio(
        BaseOptions(
          baseUrl: 'https://reqres.in/api',
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      ),
    )
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<FlutterSecureStorage>(
      const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true)),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(secureStorage: getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(localDataSource: getIt<AuthLocalDataSource>()),
    )
    ..registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(dio: getIt()))
    ..registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: getIt()));
}
