part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AutoLoginState extends AuthState {}
class FailedState extends AuthState {}
class DoneState extends AuthState {}
