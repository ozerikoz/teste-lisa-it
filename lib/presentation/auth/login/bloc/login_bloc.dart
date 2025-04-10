import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_bloc.dart';
import 'package:teste_lisa_it/data/repositories/auth/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  LoginBloc({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  })  : _authRepository = authRepository,
        _authBloc = authBloc,
        super(const LoginState()) {
    on<EmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginRequestedEvent>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.loading));

      try {
        await _authRepository.login(
          email: event.email,
          password: event.password,
        );

        emit(state.copyWith(status: LoginStatus.success));
        _authBloc.add(AuthCheckEvent());
      } catch (e) {
        emit(state.copyWith(
          status: LoginStatus.error,
          errorMessage: e.toString(),
        ));
      }
    });
  }
}
