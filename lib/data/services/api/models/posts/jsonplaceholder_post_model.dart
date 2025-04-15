import 'package:json_annotation/json_annotation.dart';

part 'jsonplaceholder_post_model.g.dart';

@JsonSerializable()
class JsonPlaceholderPostModel {
  /// The ID of the user who created the post.
  final int userId;

  /// The ID of the post.
  final int id;

  /// The title of the post.
  final String title;

  /// The body content of the post.
  final String body;

  JsonPlaceholderPostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory JsonPlaceholderPostModel.fromJson(Map<String, dynamic> json) =>
      _$JsonPlaceholderPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlaceholderPostModelToJson(this);
}
