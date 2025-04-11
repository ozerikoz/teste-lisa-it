import 'package:flutter/material.dart';
import 'package:teste_lisa_it/presentation/core/widgets/app_bar.dart';
import 'package:teste_lisa_it/presentation/home/models/post_user_profile_ui_model.dart';

/// A page that displays the post user profile
class PostUserProfilePage extends StatelessWidget {
  /// Model that contains the post user profile data
  final PostUserProfileUIModel postUser;

  /// Constructor for [PostUserProfilePage]
  /// [postUser] is required
  const PostUserProfilePage({
    super.key,
    required this.postUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TesteLisaAppBar(title: 'Detalhe do perfil'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Post user image
                CircleAvatar(
                  backgroundImage: NetworkImage(postUser.imageUrl),
                  radius: 30,
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Post user name
                    Text(
                      postUser.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    // Post user posts count
                    Text.rich(
                      TextSpan(
                          text: "Total de posts: ",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: postUser.postCount.toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ]),
                    ),
                    const SizedBox(height: 8),
                    // Post user age
                    Text.rich(
                      TextSpan(
                          text: "Idade: ",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "${postUser.age} anos",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ]),
                    ),
                    const SizedBox(height: 8),
                    // Post user interests
                    if (postUser.interests.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gostos:',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: postUser.interests
                                .map((interest) => Chip(
                                      label: Text(interest),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
