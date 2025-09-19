import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/domain/domain.dart';
import 'package:uuid/uuid.dart';

abstract interface class AuthLocalDataSource {
  Future<Result<User>> login({required final String username, required final String password});
  Future<Result<void>> logout();
  Future<Result<User?>> getLoggedUser();
  Future<Result<void>> saveLoggedUser({required final User user});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required final FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;
  final _uuid = const Uuid();

  @override
  Future<Result<User>> login({
    required final String username,
    required final String password,
  }) async {
    try {
      // TODO: implement login
      // Validate username and password with Data from Local Data Source

      // For now, use mock data
      return Result.ok(
        User(
          id: _uuid.v4(),
          email: '$username@mail.com',
          username: username,
          firstName: username.toCapitalCase(),
          lastName: username.toCapitalCase(),
          avatar:
              'https://gravatar.com/avatar/942aeb9be19e8dd7cf22682bb385e4d0?s=400&d=robohash&r=x',
        ),
      );
    } catch (e) {
      return Result.error(Exception('Failed to login: $e'));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _secureStorage.deleteAll();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to delete User from secure storage: $e'));
    }
  }

  @override
  Future<Result<User?>> getLoggedUser() async {
    try {
      final String? userJson = await _secureStorage.read(key: 'user');
      if (userJson == null || userJson.isEmpty) {
        return Result.ok(null);
      }

      final User user = User.fromJson(jsonDecode(userJson) as JSON);
      return Result.ok(user);
    } catch (e) {
      return Result.error(Exception('Failed to parse User from secure storage: $e'));
    }
  }

  @override
  Future<Result<void>> saveLoggedUser({required final User user}) async {
    try {
      final String jsonString = jsonEncode(user.toJson());
      await _secureStorage.write(key: 'user', value: jsonString);
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to store User to secure storage: $e'));
    }
  }
}
