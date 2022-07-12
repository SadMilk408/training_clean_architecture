import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';

abstract class LoginLocalDataSource {
  Future<LoginModel>? getLastLogin();

  Future<void>? cacheLogin(LoginModel loginModel);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<LoginModel>? getLastLogin() {
    final jsonString = sharedPreferences.getString(cachedLogin);
    if (jsonString != null) {
      return Future.value(LoginModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheLogin(LoginModel loginModelToCache) {
    return sharedPreferences.setString(
      cachedLogin,
      jsonEncode(loginModelToCache.toJson()),
    );
  }
}
