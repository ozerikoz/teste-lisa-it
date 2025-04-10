part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthCheckEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}
