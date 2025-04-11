import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_bloc.dart';
import 'package:teste_lisa_it/presentation/core/themes/colors.dart';

/// A button widget that allows the user to log out of the application.
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
  });

  /// The text to display on the button.
  final String text;

  /// The icon to display on the button.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<AuthBloc>().add(AuthLogoutEvent());
      },
      icon: Icon(
        icon,
        color: AppColors.white1,
        size: 16,
      ),
      label: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppColors.white1,
              fontWeight: FontWeight.bold,
            ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.red1,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
