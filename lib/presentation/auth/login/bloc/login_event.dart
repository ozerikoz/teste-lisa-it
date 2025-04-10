part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailChangedEvent extends LoginEvent {
  final String email;

  EmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChangedEvent extends LoginEvent {
  final String password;

  PasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginRequestedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginRequestedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
