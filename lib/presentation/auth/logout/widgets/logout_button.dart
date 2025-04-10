import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_bloc.dart';

/// A button that allows the user to log out of the application.
///
/// When pressed, it dispatches a [LogoutRequestedEvent] event to the [AuthBloc].
class LogoutButton extends StatelessWidget {
  /// Creates a logout button.
  ///
  /// The [text] parameter defaults to 'Logout'.
  /// The [icon] parameter defaults to Icons.logout.
  const LogoutButton({
    super.key,
    this.text = 'Logout',
    this.icon = Icons.logout,
    this.style,
  });

  /// The text to display on the button.
  final String text;

  /// The icon to display on the button.
  final IconData icon;

  /// The button style to apply.
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<AuthBloc>().add(AuthLogoutEvent());
      },
      icon: Icon(icon),
      label: Text(text),
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
    );
  }
}
