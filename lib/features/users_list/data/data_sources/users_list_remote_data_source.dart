import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

abstract class UsersListRemoteDataSource {
  /// Calls the https://randomuser.me/api/ endpoint.
  ///
  /// Throws a [ServesException] for all error codes.
  Future<UsersListModel>? getUsersList(int? page, int? results);
}

class UsersListRemoteDataSourceImpl implements UsersListRemoteDataSource {
  final http.Client client;

  UsersListRemoteDataSourceImpl({required this.client});

  @override
  Future<UsersListModel>? getUsersList(int? page, int? results) =>
      _getUsersFromUrl(Uri.https('randomuser.me', '/api/', {
        'page': '$page',
        'results': '$results'
      }));

  Future<UsersListModel> _getUsersFromUrl(Uri uri) async {
    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UsersListModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(message: 'Ошибка сервера');
    }
  }
}
