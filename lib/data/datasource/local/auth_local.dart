import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/data/data.dart';
import 'package:userapp/domain/domain.dart';

abstract interface class AuthLocalDataSource {
  Future<Result<User>> login({required final String username, required final String password});
  Future<Result<void>> logout();
  Future<Result<User?>> getLoggedUser();
  Future<Result<void>> saveLoggedUser({required final User user});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required final FlutterSecureStorage secureStorage,
    required final AppDatabase database,
  }) : _secureStorage = secureStorage,
       _database = database;

  final FlutterSecureStorage _secureStorage;
  final AppDatabase _database;

  @override
  Future<Result<User>> login({
    required final String username,
    required final String password,
  }) async {
    try {
      // TODO: implement login
      // Validate username and password with Data from Local Data Source
      final List<LocalUser> users = await _database.allUsers;

      for (final user in users) {
        if (user.username == username && user.password == password) {
          return Result.ok(
            User(id: user.id, email: user.email, username: user.username, avatar: user.avatar),
          );
        }
      }

      return Result.error(Exception('User not found'));

      // // For now, use mock data
      // return Result.ok(
      //   User(
      //     id: DateTime.now().millisecondsSinceEpoch,
      //     email: '$username@mail.com',
      //     username: username,
      //     firstName: username.toCapitalCase(),
      //     lastName: username.toCapitalCase(),
      //     avatar:
      //         'https://gravatar.com/avatar/942aeb9be19e8dd7cf22682bb385e4d0?s=400&d=robohash&r=x',
      //   ),
      // );
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
