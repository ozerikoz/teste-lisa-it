import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:teste_lisa_it/presentation/core/themes/colors.dart";

/// A post card widget with post and user informations, title, and body.
/// It allows the body to be expanded or collapsed based on user interaction.
class PostCard extends StatefulWidget {
  /// e.g "Titulo do post"
  final String title;

  /// e.g "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
  final String body;

  /// e.g "Pedro Silva"
  final String postUserName;

  /// e.g "https://example.com/user_image.jpg"
  final String postUserImageUrl;

  /// Callback function when the card is tapped.
  final Function()? onTap;

  /// Callback function when the post user profile is tapped.
  final Function()? onTapPostUserProfile;

  const PostCard({
    super.key,
    required this.title,
    required this.body,
    required this.postUserName,
    required this.postUserImageUrl,
    this.onTap,
    this.onTapPostUserProfile,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  /// Flag to track if the body is expanded or collapsed.
  bool _isExpanded = false;

  /// Character limit for the body text before truncation.
  static const _bodyCharacterLimit = 100;

  @override
  Widget build(BuildContext context) {
    // Check if the body is truncated based on the character limit
    final bool isBodyTruncated = widget.body.length > _bodyCharacterLimit;

    // Display the full body if expanded or if it is not truncated
    final String displayedBody = _isExpanded || !isBodyTruncated
        ? widget.body
        : "${widget.body.substring(0, _bodyCharacterLimit)}...";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: double.infinity,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User infos
                InkWell(
                  onTap: widget.onTapPostUserProfile,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // User image
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.postUserImageUrl),
                        radius: 20,
                      ),
                      const SizedBox(width: 8),
                      // User name
                      Text(
                        widget.postUserName,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Post title
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                // Post body
                Text.rich(
                  TextSpan(
                    text: displayedBody,
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      // Show a message to expand or collapse the body
                      if (isBodyTruncated)
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                          text: _isExpanded ? " Ver menos" : " Ver mais",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.grey3,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
