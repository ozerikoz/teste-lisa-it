import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/data/repositories/auth/auth_repository.dart';
import 'package:teste_lisa_it/domain/entities/user/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// A notifier to manage the authentication refresh state in router.
final authRefreshNotifier = ValueNotifier<bool>(false);

/// AuthBloc that manages the authentication state of the app.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState()) {
    on<AuthCheckEvent>(_onAuthCheckEvent);
    on<AuthLogoutEvent>(_onAuthLogoutEvent);
  }

  /// Function to handle the authentication check event
  void _onAuthCheckEvent(
    AuthCheckEvent event,
    Emitter<AuthState> emit,
  ) async {
    final User? user = await _authRepository.isAuthenticated();

    if (user != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));

      authRefreshNotifier.value = true;
    } else {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
      ));
      authRefreshNotifier.value = false;
    }
  }

  /// Function to handle the logout event
  void _onAuthLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();

    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
    ));

    authRefreshNotifier.value = false;
  }
}
