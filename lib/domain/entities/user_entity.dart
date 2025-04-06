import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userUid': userUid,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userUid: map['userUid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileImageUrl: map['profileImageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
