import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teste_lisa_it/core/router/routes.dart';
import 'package:teste_lisa_it/presentation/core/themes/colors.dart';
import 'package:teste_lisa_it/presentation/core/widgets/app_bar.dart';
import 'package:teste_lisa_it/presentation/home/bloc/posts_bloc.dart';
import 'package:teste_lisa_it/presentation/home/widgets/home_error_view_widget.dart';
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
      if (postsBloc.state.status == PostsStatus.loading ||
          postsBloc.state.status == PostsStatus.failure) {
        return;
      }

      // Call [FetchPostsEvent] to load more posts
      // and increment the page number
      postsBloc.add(FetchPostsEvent(page: postsBloc.state.page + 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TesteLisaAppBar(title: "Listagem de posts"),
      body: BlocBuilder<PostsBloc, PostsState>(
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
            return HomeErrorViewWidget(
              errorMessage:
                  state.errorMessage ?? "Algo deu errado ao carregar os posts!",
              onRetry: () {
                context.read<PostsBloc>().add(
                      FetchPostsEvent(limit: 10, page: 1),
                    );
              },
            );
            // Success state
          } else if (state.status == PostsStatus.success ||
              state.status == PostsStatus.loading && state.posts.isNotEmpty ||
              state.status == PostsStatus.failure && state.posts.isNotEmpty) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length,
              padding: const EdgeInsets.only(bottom: 48),
              itemBuilder: (context, index) {
                final post = state.posts[index];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PostCard(
                        key: ValueKey("post-card-$index"),
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

                    // If the user reach the end of the list and fetching posts failed
                    // show a message
                    if (index == state.posts.length - 1 &&
                        state.status == PostsStatus.failure &&
                        !state.reachedMaxPage)
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 48),
                        child: Column(
                          children: [
                            Text(
                              state.errorMessage ??
                                  "Algo deu errado ao carregar mais posts! \n ${state.errorMessage}"
                                      "Algo deu errado ao carregar mais posts!",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onError,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<PostsBloc>().add(
                                      FetchPostsEvent(page: state.page + 1),
                                    );
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: AppColors.white1,
                              ),
                              label: Text(
                                'Tentar Novamente',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: AppColors.white1,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.copyWith(
                                    backgroundColor: WidgetStateProperty.all(
                                        Theme.of(context).colorScheme.onError),
                                  ),
                            ),
                          ],
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
