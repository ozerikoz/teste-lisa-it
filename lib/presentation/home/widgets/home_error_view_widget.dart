import 'package:flutter/material.dart';
import 'package:teste_lisa_it/presentation/core/themes/colors.dart';

/// A home error view widget that displays an error message and a retry button.
class HomeErrorViewWidget extends StatelessWidget {
  /// The error message to display.
  final String errorMessage;

  /// The callback function to execute when the retry button is pressed.
  final Function() onRetry;

  const HomeErrorViewWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: theme.colorScheme.onError,
              size: 64,
            ),
            const SizedBox(height: 24),
            Text(
              'Ops! Algo deu errado',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => onRetry(),
              icon: Icon(
                Icons.refresh,
                color: AppColors.white1,
              ),
              label: Text(
                'Tentar Novamente',
                style: theme.textTheme.labelLarge!.copyWith(
                  color: AppColors.white1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: theme.elevatedButtonTheme.style?.copyWith(
                backgroundColor:
                    WidgetStateProperty.all(theme.colorScheme.onError),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
