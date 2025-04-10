part of 'login_bloc.dart';

enum LoginStatus { idle, loading, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.idle,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, status, errorMessage];
}
