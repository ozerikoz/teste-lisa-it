part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPostsEvent extends PostsEvent {
  final int limit;
  final int page;

  FetchPostsEvent({
    this.limit = 10,
    this.page = 1,
  });

  @override
  List<Object?> get props => [limit, page];
}
