import 'dart:async';

import 'package:userapp/core/core.dart';
import 'package:userapp/domain/domain.dart';

abstract interface class UserRepository {
  Future<Result<List<User>>> getUsers({required final int page, final int perPage = 6});
}
