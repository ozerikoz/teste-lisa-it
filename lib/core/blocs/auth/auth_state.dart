import 'package:equatable/equatable.dart';
import 'package:teste_lisa_it/domain/entities/user/user_entity.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
