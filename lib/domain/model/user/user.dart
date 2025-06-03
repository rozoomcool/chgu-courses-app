import 'package:coursera/domain/model/profile/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../profile/profile.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User(
    this.id,
    this.password,
    this.profile, {
    required this.email,
    required this.role,
  });

  final int id;
  final String email;
  final String? password;
  final String role;
  final Profile? profile;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum Role { STUDENT, ADMIN, MODERATOR, TEACHER }