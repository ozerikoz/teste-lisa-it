import 'package:teste_lisa_it/domain/entities/post/post_entity.dart';
import 'package:teste_lisa_it/domain/entities/post_user/post_user_entity.dart';

class PostInfoDto {
  final PostUser postUser;
  final Post post;

  const PostInfoDto({
    required this.postUser,
    required this.post,
  });
}
