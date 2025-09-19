import 'dart:async';

import 'package:userapp/core/core.dart';
import 'package:userapp/domain/domain.dart';

abstract interface class AuthRepository {
  Future<Result<User>> login({required final String username, required final String password});
  Future<Result<void>> logout();

  Future<Result<void>> saveLoggedUserToSecureStorage({required final User user});
  Future<Result<User?>> getLoggedUserFromSecureStorage();
}
