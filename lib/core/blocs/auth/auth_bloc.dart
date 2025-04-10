import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_event.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_state.dart';
import 'package:teste_lisa_it/data/repositories/auth/auth_repository.dart';

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
  ) {
    // Check if the user is authenticated by user object
    if (event.user != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: event.user,
      ));
    } else {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
      ));
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
  }
}
