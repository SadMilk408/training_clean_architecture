import 'package:training_clean_architecture/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity{
  const LoginModel({required super.username});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(username: json['username']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username' : username
    };
  }
}