import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teste_lisa_it/core/router/routes.dart';
import 'package:teste_lisa_it/presentation/core/widgets/app_bar.dart';
import 'package:teste_lisa_it/presentation/home/models/post_ui_model.dart';

class PostDetailsPage extends StatelessWidget {
  final PostUIModel post;

  const PostDetailsPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TesteLisaAppBar(title: "Detalhes do Post"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post user profile
            InkWell(
              onTap: () {
                context.push(
                  Routes.postUserProfile,
                  extra: post.postUserProfile,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(post.postUserProfile.imageUrl),
                    radius: 30,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    post.postUserProfile.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Post title
            Text(
              post.title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            // Post body
            Text(
              post.body,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
