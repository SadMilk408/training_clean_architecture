import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/user_info/data/%20data_sources/user_info_local_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../users_list/data/data_sources/users_list_local_data_source_test.mocks.dart';

void main() {
  late UserInfoLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  const tUserInfoModel = UsersListModel(
    results: [
      UsersListResultsModel(
        name: UsersListResultsNameModel(
          title: 'title',
          first: 'first',
          last: 'last',
        ),
        location: UsersListResultsLocationModel(
          street: UsersListResultsLocationStreetModel(
            number: 8554,
            name: 'street',
          ),
          city: 'city',
          state: 'state',
          postcode: 1,
          coordinates: UsersListResultsLocationCoordinatesModel(
            latitude: 'latitude',
            longitude: 'longitude',
          ),
        ),
        picture: UsersListResultsPictureModel(
          large: 'large',
          medium: 'medium',
          thumbnail: 'thumbnail',
        ),
      ),
    ],
  );

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        UserInfoLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getUserInfo', () {
    test('should return UserInfoModel from SharedPreferences', () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('users_list.json'));
      // act
      final result = await dataSource.getUsersInfo();
      // assert
      verify(mockSharedPreferences.getString(cachedUserInfo));
      expect(result, equals(tUserInfoModel));
    });

    test('should throw CacheException when there is not a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getUsersInfo;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheUsersInfo', () {
    test('cacheUsersList', () {
      // arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheUsersInfo(tUserInfoModel);
      // assert
      final expectedJsonString = jsonEncode(tUserInfoModel.toJson());
      verify(
        mockSharedPreferences.setString(cachedUserInfo, expectedJsonString),
      );
    });
  });
}
