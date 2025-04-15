import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_bloc.dart';
import 'package:teste_lisa_it/core/exceptions/exceptions.dart';
import 'package:teste_lisa_it/data/exceptions/auth_exceptions.dart';
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
    on<LoginRequestedEvent>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.loading));

      try {
        await _authRepository.login(
          email: event.email,
          password: event.password,
        );

        emit(state.copyWith(status: LoginStatus.success));
        _authBloc.add(AuthCheckEvent());
      } on InvalidCredentialsException {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: "Email ou senha inválidos. Tente novamente!",
        ));
      } on NetworkException {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage:
              "Erro de conexão. Verifique sua internet e tente novamente!",
        ));
      } catch (e) {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage:
              "Erro inesperado. Por favor, tente novamente mais tarde!",
        ));
      }
    });

    on<LoginPasswordVisibilityChangedEvent>((event, emit) {
      emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
    });

    on<LoginAutovalidateModeChangedEvent>((event, emit) {
      emit(state.copyWith(autovalidateMode: event.autovalidateMode));
    });
  }
}
