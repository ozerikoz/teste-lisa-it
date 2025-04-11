import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_bloc.dart';
import 'package:teste_lisa_it/core/router/routes.dart';
import 'package:teste_lisa_it/presentation/auth/login/bloc/login_bloc.dart';
import 'package:teste_lisa_it/presentation/auth/login/pages/login_page.dart';
import 'package:teste_lisa_it/presentation/home/bloc/posts_bloc.dart';
import 'package:teste_lisa_it/presentation/home/pages/home_page.dart';

/// Router configuration for the app.
/// Listens to changes in [AuthBloc] to redirect the user
/// to /login when the user logs out.
GoRouter router() => GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      redirect: _redirect,
      refreshListenable: authRefreshNotifier,
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (context, state) => BlocProvider(
            create: (context) => LoginBloc(
              authRepository: context.read(),
              authBloc: context.read(),
            ),
            child: LoginPage(),
          ),
        ),
        GoRoute(
          path: Routes.home,
          builder: (context, state) => BlocProvider(
            create: (context) => PostsBloc(
              postsRepository: context.read(),
              postUsersRepository: context.read(),
            )..add(
                FetchPostsEvent(),
              ),
            child: HomePage(),
          ),
        ),
      ],
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
