import 'package:json_annotation/json_annotation.dart';

part 'jsonplaceholder_post_model.g.dart';

@JsonSerializable()
class JsonPlaceholderPostModel {
  final int userId;
  final int id;
  final String title;
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
