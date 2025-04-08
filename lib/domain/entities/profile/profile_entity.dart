import 'package:json_annotation/json_annotation.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class Profile {
  final String userId;
  final String name;
  final int age;
  final List<String> interests;
  final String imageUrl;
  final int postCount;

  Profile({
    required this.userId,
    required this.name,
    required this.age,
    required this.interests,
    required this.imageUrl,
    required this.postCount,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
