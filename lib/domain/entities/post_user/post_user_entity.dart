import 'package:json_annotation/json_annotation.dart';

part 'post_user_entity.g.dart';

@JsonSerializable()
class PostUser {
  final int userId;
  final String name;
  final int age;
  final List<String> interests;
  final String imageUrl;
  final int postCount;

  PostUser({
    required this.userId,
    required this.name,
    required this.age,
    required this.interests,
    required this.imageUrl,
    required this.postCount,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) =>
      _$PostUserFromJson(json);

  Map<String, dynamic> toJson() => _$PostUserToJson(this);
}
