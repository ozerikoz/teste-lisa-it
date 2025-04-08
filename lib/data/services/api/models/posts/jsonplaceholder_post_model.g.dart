// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jsonplaceholder_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlaceholderPostModel _$JsonPlaceholderPostModelFromJson(
        Map<String, dynamic> json) =>
    JsonPlaceholderPostModel(
      userId: (json['userId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$JsonPlaceholderPostModelToJson(
        JsonPlaceholderPostModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
