import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/data/data.dart';
import 'package:userapp/domain/domain.dart';

final getIt = GetIt.instance;

Future<void> injection() async {
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
    ..registerSingleton<AppDatabase>(AppDatabase())
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(secureStorage: getIt(), database: getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(localDataSource: getIt<AuthLocalDataSource>()),
    )
    ..registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(dio: getIt()))
    ..registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: getIt()));

  List<LocalUser> users = await getIt<AppDatabase>().allUsers;
  log('isi user before $users', name: 'InjectionContainer');

  // Insert pre defined user if not exist
  if (users.isEmpty) {
    await getIt<AppDatabase>()
        .into(getIt<AppDatabase>().localUsers)
        .insert(
          LocalUsersCompanion.insert(
            email: 'admin@mail.com',
            username: 'admin',
            password: 'admin',
            avatar:
                'https://gravatar.com/avatar/942aeb9be19e8dd7cf22682bb385e4d0?s=400&d=robohash&r=x',
          ),
        );
    await getIt<AppDatabase>()
        .into(getIt<AppDatabase>().localUsers)
        .insert(
          LocalUsersCompanion.insert(
            email: 'user@mail.com',
            username: 'user',
            password: 'user',
            avatar:
                'https://gravatar.com/avatar/942aeb9be19e8dd7cf22682bb385e4d0?s=400&d=robohash&r=x',
          ),
        );
  }

  users = await getIt<AppDatabase>().allUsers;
  log('isi user after $users', name: 'InjectionContainer');
}
