import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/data/repositories/post_users/post_users_repository.dart';
import 'package:teste_lisa_it/data/repositories/posts/posts_repository.dart';
import 'package:teste_lisa_it/domain/entities/post_user/post_user_entity.dart';
import 'package:teste_lisa_it/presentation/home/dtos/post_info_dto.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository _postsRepository;
  final PostUsersRepository _postUsersRepository;

  PostsBloc({
    required PostsRepository postsRepository,
    required PostUsersRepository postUsersRepository,
  })  : _postsRepository = postsRepository,
        _postUsersRepository = postUsersRepository,
        super(const PostsState()) {
    on<FetchPostsEvent>(_onFetchPostsRequestedEvent);
  }

  void _onFetchPostsRequestedEvent(
    FetchPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: PostsStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      // fetch new posts
      final newPosts = await _postsRepository.fetchPosts(
        limit: event.limit,
        page: event.page,
      );

      // Check if all posts have been loaded
      if (newPosts.isEmpty && event.page > 1) {
        emit(
          state.copyWith(
            status: PostsStatus.success,
            reachedMaxPage: true,
          ),
        );
        return;
      }

      // local var to store the posts with user info
      final postInfoList = <PostInfoDto>[];

      // fetch the postUser for each post
      for (int i = 0; i < newPosts.length; i++) {
        final post = newPosts[i];

        // fetch the postUser by userId
        final postUser =
            await _postUsersRepository.getUserById(userId: post.userId);

        // create the PostInfoDto with the post and postUser info
        final postInfo = PostInfoDto(
          postUser: PostUser(
            userId: post.userId,
            name: postUser!.name,
            age: postUser.age,
            interests: postUser.interests,
            imageUrl: postUser.imageUrl,
            postCount: postUser.postCount,
          ),
          post: post,
        );

        // add the new postInfo to the list
        postInfoList.add(postInfo);
      }

      // merge the new posts with the existing ones
      final posts = [...state.posts, ...postInfoList];

      emit(state.copyWith(
        status: PostsStatus.success,
        posts: posts,
        page: event.page,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PostsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
