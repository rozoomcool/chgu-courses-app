import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  const Profile({
    this.id,
    this.fullname,
    this.avatarUrl,
    this.birthday,
  });

  final int? id;
  final String? fullname;
  final DateTime? birthday;
  final String? avatarUrl;

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
