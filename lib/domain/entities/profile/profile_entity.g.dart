// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      userId: json['userId'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      postCount: (json['postCount'] as num).toInt(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'age': instance.age,
      'interests': instance.interests,
      'imageUrl': instance.imageUrl,
      'postCount': instance.postCount,
    };
