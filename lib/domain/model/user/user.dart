import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User(
    this.id,
    this.password, {
    required this.email,
    required this.role,
  });

  final int id;
  final String email;
  final String? password;
  final String role;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum Role { STUDENT, ADMIN, MODERATOR, TEACHER }