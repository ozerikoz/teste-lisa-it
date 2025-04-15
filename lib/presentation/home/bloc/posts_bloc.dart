import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/core/exceptions/exceptions.dart';
import 'package:teste_lisa_it/data/repositories/post_users/post_users_repository.dart';
import 'package:teste_lisa_it/data/repositories/posts/posts_repository.dart';
import 'package:teste_lisa_it/presentation/home/models/post_ui_model.dart';
import 'package:teste_lisa_it/presentation/home/models/post_user_profile_ui_model.dart';

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
      final postInfoList = <PostUIModel>[];

      // fetch the postUser for each post
      for (int i = 0; i < newPosts.length; i++) {
        final post = newPosts[i];

        // fetch the postUser by userId
        final postUser =
            await _postUsersRepository.getUserById(userId: post.userId);

        // create the PostInfoDto with the post and postUser info
        final postInfo = PostUIModel(
          title: post.title,
          body: post.body,
          postUserProfile: PostUserProfileUIModel(
            userId: postUser!.userId,
            name: postUser.name,
            imageUrl: postUser.imageUrl,
            age: postUser.age,
            interests: postUser.interests,
            postCount: postUser.postCount,
          ),
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
    } on NetworkException {
      emit(state.copyWith(
        status: PostsStatus.failure,
        errorMessage:
            "Erro de conexão. Verifique sua internet e tente novamente!",
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PostsStatus.failure,
        errorMessage: "Algo deu errado. Por favor, tente novamente mais tarde!",
      ));
    }
  }
}
