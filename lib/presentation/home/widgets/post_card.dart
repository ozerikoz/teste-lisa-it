import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String body;
  final String postUserName;
  final String postUserImageUrl;

  const PostCard({
    super.key,
    required this.title,
    required this.body,
    required this.postUserName,
    required this.postUserImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User infos row
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(postUserImageUrl),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  postUserName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Post title
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            // Post body
            Text(
              body,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
