import 'package:userapp/core/core.dart';
import 'package:userapp/data/data.dart';
import 'package:userapp/domain/domain.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required final UserRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final UserRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<User>>> getUsers({required final int page, final int perPage = 6}) =>
      _remoteDataSource.getUsers(page: page, perPage: perPage);
}

// class MockUserRepositoryImpl implements UserRepository {
//   @override
//   Future<Result<List<User>>> getUsers({
//     required final int page,
//     final int perPage = 6,
//   }) => Future.value(
//     Result.ok(
//       List.generate(
//         12,
//         (final int index) => User(
//           id: index.toString(),
//           email: 'george.bluth@reqres.in',
//           firstName: 'user $index',
//           lastName: 'user $index',
//           avatar:
//               'https://gravatar.com/avatar/942aeb9be19e8dd7cf22682bb385e4d0?s=400&d=robohash&r=x',
//         ),
//       ),
//     ),
//   );
// }

/*
  User Response From Reqres

    {
      "id": 1,
      "email": "george.bluth@reqres.in",
      "first_name": "George",
      "last_name": "Bluth",
      "avatar": "https://reqres.in/img/faces/1-image.jpg"
    }

*/
