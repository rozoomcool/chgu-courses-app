import 'package:freezed_annotation/freezed_annotation.dart';

import '../user/user.dart';

part 'jwt_payload.g.dart';

@JsonSerializable()
class JwtPayload {
  const JwtPayload({
    required this.user,
    required this.access,
    required this.refresh,
  });

  final String access;
  final String refresh;
  final User user;

  factory JwtPayload.fromJson(Map<String, Object?> json) =>
      _$JwtPayloadFromJson(json);
  
  Map<String, dynamic> toJson() => _$JwtPayloadToJson(this);
}
