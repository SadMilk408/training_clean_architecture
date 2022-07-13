import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

abstract class UserInfoLocalDataSource {
  Future<List<UsersListResultsModel>> getUsersInfo();
  Future<void> cacheUserInfo(List<UsersListResultsModel> usersListResultsModel);
}

class UserInfoLocalDataSourceImpl implements UserInfoLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserInfoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<UsersListResultsModel>> getUsersInfo() {
    final jsonStringList = sharedPreferences.getStringList(cachedLogin);
    if (jsonStringList != null) {
      return Future.value(jsonStringList.map((e) => UsersListResultsModel.fromJson(jsonDecode(e))).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserInfo(List<UsersListResultsModel> usersListResultsModel) {
    return sharedPreferences.setStringList(
      cachedUserInfo,
      [jsonEncode(usersListResultsModel)],
    );
  }
}