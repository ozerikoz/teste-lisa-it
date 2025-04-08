import 'package:json_annotation/json_annotation.dart';

part 'post_entity.g.dart';

@JsonSerializable()
class Post {
  final int userId;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
