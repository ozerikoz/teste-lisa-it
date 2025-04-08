import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class User {
  final String userUid;
  final String name;
  final String email;
  final String profileImageUrl;

  const User({
    required this.userUid,
    required this.name,
    required this.email,
    required this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
