import 'package:flutter/material.dart';
import 'package:teste_lisa_it/presentation/auth/logout/widgets/logout_button.dart';

/// A custom AppBar widget with [LogoutButton].
class TesteLisaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TesteLisaAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: LogoutButton(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
