import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_remote_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'users_list_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late UsersListRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = UsersListRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('users_list.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('users_list.json'), 404));
  }

  group('getUsersList', () {
    const tPage = 1;
    const tResults = 10;
    final tUsersListModel =
        UsersListModel.fromJson(jsonDecode(fixture('users_list.json')));

    test(
      '''should perform a GET request on a URL with number being
         the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        //act
        dataSource.getUsersList(1, 10);
        //assert
        verify(mockHttpClient.get(
            Uri.https('randomuser.me', '/api/',
                {'page': '$tPage', 'results': '$tResults'}),
            headers: {
              'Content-Type': 'application/json',
            }));
      },
    );

    test(
      'should return UsersList when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        //act
        final result = await dataSource.getUsersList(tPage, tResults);
        //assert
        expect(result, equals(tUsersListModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        //act
        final call = dataSource.getUsersList;
        //assert
        expect(() => call(tPage, tResults), throwsA(isA<ServerException>()));
      },
    );
  });
}
