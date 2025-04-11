class PostUserProfileUIModel {
  final int userId;
  final String name;
  final String imageUrl;
  final int age;
  final List<String> interests;
  final int postCount;

  const PostUserProfileUIModel({
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.age,
    required this.interests,
    required this.postCount,
  });
}
