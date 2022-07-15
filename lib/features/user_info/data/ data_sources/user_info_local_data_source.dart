import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

abstract class UserInfoLocalDataSource {
  Future<UsersListModel>? getUsersInfo();
  Future<void>? cacheUsersInfo(UsersListModel usersListResultsModel);
}

class UserInfoLocalDataSourceImpl implements UserInfoLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserInfoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UsersListModel>? getUsersInfo() {
    final jsonStringList = sharedPreferences.getString(cachedUserInfo);
    if (jsonStringList != null) {
      return Future.value(UsersListModel.fromJson(jsonDecode(jsonStringList)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheUsersInfo(UsersListModel usersListResultsModel) {
    return sharedPreferences.setString(
      cachedUserInfo,
      jsonEncode(usersListResultsModel),
    );
  }
}