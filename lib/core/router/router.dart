import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_bloc.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_state.dart';
import 'package:teste_lisa_it/core/router/routes.dart';

/// Router configuration for the app.
/// Listens to changes in [AuthBloc] to redirect the user
/// to /login when the user logs out.
GoRouter router() => GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      redirect: (context, state) => _redirect(context, state),
      routes: [],
    );

Future<String?> _redirect(
  BuildContext context,
  GoRouterState state,
) async {
  final authBloc = context.read<AuthBloc>();

  final isAuthenticated = authBloc.state.status == AuthStatus.authenticated;

  if (state.matchedLocation == Routes.login && isAuthenticated) {
    return Routes.home;
  } else if (!isAuthenticated) {
    return Routes.login;
  }

  return null;
}
