import 'package:teste_lisa_it/domain/entities/user/user_entity.dart';

abstract class AuthEvent {}

class AuthCheckEvent extends AuthEvent {
  final User? user;

  AuthCheckEvent({this.user});
}

class AuthLogoutEvent extends AuthEvent {}
