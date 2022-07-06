part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AutoLoginState extends AuthState {}

/// TODO: remove
class AutoLoginFailState extends AuthState {}
