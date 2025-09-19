import 'dart:async';

import 'package:userapp/core/core.dart';
import 'package:userapp/domain/domain.dart';
import 'package:uuid/uuid.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   AuthRepositoryImpl({required final AuthRemoteDataSource remoteDataSource})
//     : _remoteDataSource = remoteDataSource;

//   final AuthRemoteDataSource _remoteDataSource;

//   @override
//   Future<Result<User>> login({
//     required final String username,
//     required final String password,
//   }) => _remoteDataSource.login(username: username, password: password);

//   @override
//   Future<Result<void>> logout() => _remoteDataSource.logout();

//   @override
//   Future<Result<User?>> getLoggedUserToSecureStorage() {
//     // TODO: implement getLoggedUserToSecureStorage
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<void>> saveLoggedUserToSecureStorage({required User user}) {
//     // TODO: implement saveLoggedUserToSecureStorage
//     throw UnimplementedError();
//   }
// }

class MockAuthRepositoryImpl implements AuthRepository {
  final _uuid = const Uuid();

  @override
  Future<Result<User>> login({required final String username, required final String password}) =>
      Future.value(
        Result.ok(
          User(
            id: _uuid.v4(),
            email: '$username@mail.com',
            username: username,
            firstName: username.toCapitalCase(),
            lastName: username.toCapitalCase(),
            avatar:
                'https://gravatar.com/avatar/942aeb9be19e8dd7cf22682bb385e4d0?s=400&d=robohash&r=x',
          ),
        ),
      );

  @override
  Future<Result<void>> logout() => Future.value(Result.ok(null));

  @override
  Future<Result<User?>> getLoggedUserToSecureStorage() => Future.value(Result.ok(null));

  @override
  Future<Result<void>> saveLoggedUserToSecureStorage({required final User user}) =>
      Future.value(Result.ok(null));
}
