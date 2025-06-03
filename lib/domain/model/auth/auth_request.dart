import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.g.dart';


@JsonSerializable()
class AuthRequest {
  const AuthRequest({required this.email, required this.password});

  final String email;
  final String password;

  factory AuthRequest.fromJson(Map<String, Object?> json) =>
      _$AuthRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
