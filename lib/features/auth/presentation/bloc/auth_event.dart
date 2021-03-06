part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AutoAuthEvent extends AuthEvent {
  final BuildContext context;
  AutoAuthEvent({required this.context});
}

class SaveLoginToCacheEvent extends AuthEvent {
  final LoginModel loginModel;
  final BuildContext context;

  SaveLoginToCacheEvent({required this.loginModel, required this.context});
}