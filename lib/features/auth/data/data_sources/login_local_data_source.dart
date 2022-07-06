import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';

abstract class LoginLocalDataSource {
  Future<LoginModel>? getLastLogin();

  Future<void>? cacheLogin(LoginModel loginModel);
}

const CACHED_LOGIN = 'CACHED_LOGIN';

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<LoginModel>? getLastLogin() {
    final jsonString = sharedPreferences.getString(CACHED_LOGIN);
    if (jsonString != null) {
      return Future.value(LoginModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheLogin(LoginModel loginModelToCache) {
    return sharedPreferences.setString(
      CACHED_LOGIN,
      jsonEncode(loginModelToCache.toJson()),
    );
  }
}
