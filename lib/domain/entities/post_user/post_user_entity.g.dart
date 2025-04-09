// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUser _$PostUserFromJson(Map<String, dynamic> json) => PostUser(
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      postCount: (json['postCount'] as num).toInt(),
    );

Map<String, dynamic> _$PostUserToJson(PostUser instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'age': instance.age,
      'interests': instance.interests,
      'imageUrl': instance.imageUrl,
      'postCount': instance.postCount,
    };
