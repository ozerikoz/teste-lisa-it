part of 'posts_bloc.dart';

enum PostsStatus { initial, loading, success, failure }

class PostsState extends Equatable {
  final PostsStatus status;
  final List<PostUIModel> posts;
  final String? errorMessage;
  final int page;
  final bool reachedMaxPage;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.errorMessage,
    this.page = 0,
    this.reachedMaxPage = false,
  });

  PostsState copyWith({
    PostsStatus? status,
    List<PostUIModel>? posts,
    String? errorMessage,
    int? page,
    bool? reachedMaxPage,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      reachedMaxPage: reachedMaxPage ?? this.reachedMaxPage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        posts,
        errorMessage,
        page,
        reachedMaxPage,
      ];
}
