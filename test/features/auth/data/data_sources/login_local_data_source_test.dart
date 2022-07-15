import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/auth/data/data_sources/login_local_data_source.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../users_list/data/data_sources/users_list_local_data_source_test.mocks.dart';

void main() {
  late LoginLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        LoginLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastLogin', () {
    final tLoginModel = LoginModel.fromJson(jsonDecode(fixture('login.json')));

    test('should return LoginModel from SharedPreferences', () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('login.json'));
      // act
      final result = await dataSource.getLastLogin();
      // assert
      verify(mockSharedPreferences.getString(cachedLogin));
      expect(result, equals(tLoginModel));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getLastLogin;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheLogin', () {
    const tLoginModel =
      LoginModel(username: 'username');

    test('should call SharedPreferences to cache the data', () async {
      // arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheLogin(tLoginModel);
      // assert
      final expectedJsonString = jsonEncode(tLoginModel.toJson());
      verify(mockSharedPreferences.setString(
          cachedLogin, expectedJsonString));
    });
  });
}
