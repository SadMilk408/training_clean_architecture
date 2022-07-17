import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

abstract class UsersListLocalDataSource {
  /// Gets the cached [UsersListModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Trows [CacheException] if no cached data is present.
  Future<UsersListModel>? getLastUsersList();

  Future<void>? cacheUsersList(UsersListModel? usersListToCache);
}

class UsersListLocalDataSourceImpl implements UsersListLocalDataSource {
  final SharedPreferences sharedPreferences;

  UsersListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UsersListModel>? getLastUsersList() {
    final jsonString = sharedPreferences.getString(cachedUsersList);
    if (jsonString != null) {
      return Future.value(UsersListModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheUsersList(UsersListModel? usersListToCache) {
    return sharedPreferences.setString(
      cachedUsersList,
      jsonEncode(usersListToCache?.toJson()),
    );
  }
}