import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

abstract class UserInfoLocalDataSource {
  Future<void> cacheUserInfo(UsersListResultsModel usersListResultsModel);
  Future<void> deleteUserInfo(UsersListResultsModel usersListResultsModel);
}

class UserInfoLocalDataSourceImpl implements UserInfoLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserInfoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheUserInfo(UsersListResultsModel usersListResultsModel) {
    // TODO: реализовать дополнение кеша, а не простую перезапись
    return sharedPreferences.setString(
      cachedUserInfo,
      jsonEncode(usersListResultsModel.toJson()),
    );
  }

  @override
  Future<void> deleteUserInfo(UsersListResultsModel usersListResultsModel) {
    // TODO: реализовать удаление конкретного юзера, а не всех
    return sharedPreferences.remove(cachedUserInfo);
  }
}