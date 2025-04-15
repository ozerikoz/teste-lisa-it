part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;
  final bool isPasswordObscure;
  final AutovalidateMode autovalidateMode;

  const LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.isPasswordObscure = true,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    bool? isPasswordObscure,
    AutovalidateMode? autovalidateMode,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        isPasswordObscure,
        autovalidateMode,
      ];
}
