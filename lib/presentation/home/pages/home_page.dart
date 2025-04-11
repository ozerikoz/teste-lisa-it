import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teste_lisa_it/core/router/routes.dart';
import 'package:teste_lisa_it/presentation/core/widgets/app_bar.dart';
import 'package:teste_lisa_it/presentation/home/bloc/posts_bloc.dart';
import 'package:teste_lisa_it/presentation/home/widgets/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() => onScrollBottom(context));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Method is called when the user scrolls to the bottom of the list.
  void onScrollBottom(BuildContext context) {
    if (_scrollController.position.pixels >
        (_scrollController.position.maxScrollExtent - 50)) {
      final postsBloc = context.read<PostsBloc>();

      // Return if the user is already loading more posts to avoid multiple calls
      if (postsBloc.state.status == PostsStatus.loading) return;

      // Call [FetchPostsEvent] to load more posts
      // and increment the page number
      postsBloc.add(FetchPostsEvent(page: postsBloc.state.page + 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TesteLisaAppBar(title: "Listagem de posts"),
      body: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {
          // todo show snackbar if PostStatus.status is failure
        },
        builder: (context, state) {
          // Initial loading state
          if (state.status == PostsStatus.loading && state.posts.isEmpty ||
              state.status == PostsStatus.initial) {
            return const Center(
              child: SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(),
              ),
            );
            // Initial error state
          } else if (state.status == PostsStatus.failure &&
              state.posts.isEmpty) {
            return Center(
              child: Text(state.errorMessage ?? "Error"),
            );
            // Success state
          } else if (state.status == PostsStatus.success ||
              state.status == PostsStatus.loading && state.posts.isNotEmpty ||
              state.status == PostsStatus.failure && state.posts.isNotEmpty) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PostCard(
                        title: post.title,
                        body: post.body,
                        postUserName: post.postUserProfile.name,
                        postUserImageUrl: post.postUserProfile.imageUrl,
                        onTap: () {
                          // Navigate to post details page
                          context.push(
                            Routes.postDetails,
                            extra: post,
                          );
                        },
                        onTapPostUserProfile: () {
                          // Navigate to post user profile page
                          context.push(
                            Routes.postUserProfile,
                            extra: post.postUserProfile,
                          );
                        },
                      ),
                    ),
                    // If the user reach the end of the list and is loading more posts
                    // show a loading indicator
                    if (index == state.posts.length - 1 &&
                        state.status == PostsStatus.loading)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),

                    // If the user reach the end of the list
                    // and has reached the max page
                    // show a message
                    if (index == state.posts.length - 1 && state.reachedMaxPage)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            "Você viu todos os posts!",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
