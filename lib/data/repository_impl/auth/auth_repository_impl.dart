import 'dart:async';

import 'package:userapp/core/core.dart';
import 'package:userapp/data/datasource/datasource.dart';
import 'package:userapp/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required final AuthLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  final AuthLocalDataSource _localDataSource;

  @override
  Future<Result<User>> login({required final String username, required final String password}) =>
      _localDataSource.login(username: username, password: password);

  @override
  Future<Result<void>> logout() => _localDataSource.logout();

  @override
  Future<Result<User?>> getLoggedUserFromSecureStorage() => _localDataSource.getLoggedUser();

  @override
  Future<Result<void>> saveLoggedUserToSecureStorage({required final User user}) =>
      _localDataSource.saveLoggedUser(user: user);
}

// class MockAuthRepositoryImpl implements AuthRepository {
//   final _uuid = const Uuid();

//   @override
//   Future<Result<User>> login({required final String username, required final String password}) =>
//       Future.value(
//         Result.ok(
//           User(
//             id: _uuid.v4(),
//             email: '$username@mail.com',
//             username: username,
//             firstName: username.toCapitalCase(),
//             lastName: username.toCapitalCase(),
//             avatar:
//                 'https://gravatar.com/avatar/942aeb9be19e8dd7cf22682bb385e4d0?s=400&d=robohash&r=x',
//           ),
//         ),
//       );

//   @override
//   Future<Result<void>> logout() => Future.value(Result.ok(null));

//   @override
//   Future<Result<User?>> getLoggedUserFromSecureStorage() => Future.value(Result.ok(null));

//   @override
//   Future<Result<void>> saveLoggedUserToSecureStorage({required final User user}) =>
//       Future.value(Result.ok(null));
// }
