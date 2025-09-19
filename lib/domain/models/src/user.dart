import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:userapp/core/core.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  @JsonSerializable(explicitToJson: true, includeIfNull: false, fieldRename: FieldRename.snake)
  factory User({
    required final String id,
    required final String email,

    // Will not null for auth user from Local DB
    final String? username,
    final String? firstName,
    final String? lastName,
    final String? avatar,
  }) = _User;

  factory User.fromJson(final JSON json) => _$UserFromJson(json);
}

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
