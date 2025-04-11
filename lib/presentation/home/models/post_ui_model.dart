import 'package:teste_lisa_it/presentation/home/models/post_user_profile_ui_model.dart';

class PostUIModel {
  final String title;
  final String body;
  final PostUserProfileUIModel postUserProfile;

  const PostUIModel({
    required this.title,
    required this.body,
    required this.postUserProfile,
  });
}
