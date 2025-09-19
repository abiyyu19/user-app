import 'package:dio/dio.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/domain/domain.dart';

abstract interface class UserRemoteDataSource {
  Future<Result<List<User>>> getUsers({required final int page, final int perPage = 6});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({required final Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<Result<List<User>>> getUsers({required final int page, final int perPage = 6}) async {
    try {
      final JSON queryParams = <String, int>{'page': page, 'per_page': perPage};
      final Response res = await _dio.get(
        '/users',
        queryParameters: queryParams,
        options: Options(headers: {'x-api-key': 'reqres-free-v1'}),
      );

      if (res.data == null || res.statusCode == null) {
        final String message =
            res.data?['message'] as String? ?? 'Server returned status ${res.statusCode}';
        return Result.error(
          DioException(
            requestOptions: res.requestOptions,
            response: res,
            type: DioExceptionType.badResponse,
            error: 'Failed to get user list: $message',
          ),
        );
      }

      final List<User> users = (res.data['data'] as List<dynamic>)
          .map((final e) => User.fromJson(e as JSON))
          .toList();

      return Result.ok(users);
    } on DioException catch (e) {
      return Result.error(
        DioException(requestOptions: e.requestOptions, response: e.response, type: e.type),
      );
    } catch (e) {
      return Result.error(
        DioException(
          requestOptions: RequestOptions(),
          error: 'Another error when getting user list: $e',
        ),
      );
    }
  }
}
