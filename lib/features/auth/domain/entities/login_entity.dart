import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String username;

  const LoginEntity({required this.username});

  @override
  List<Object?> get props => [username];
}