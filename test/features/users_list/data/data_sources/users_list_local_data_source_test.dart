import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_local_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'users_list_local_data_source_test.mocks.dart';

@GenerateMocks([
  SharedPreferences
], customMocks: [
  MockSpec<SharedPreferences>(
      as: #MockSharedPreferencesForTest, returnNullOnMissingStub: true),
])
void main() {
  late UsersListLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        UsersListLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastUsersList', () {
    final tUsersListModel =
        UsersListModel.fromJson(jsonDecode(fixture('users_list_cached.json')));

    test(
        'should return UsersList from SharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('users_list_cached.json'));
      // act
      final result = await dataSource.getLastUsersList();
      // assert
      verify(mockSharedPreferences.getString(cachedUsersList));
      expect(result, equals(tUsersListModel));
    });

    test('should throw CacheException when there is not a cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getLastUsersList;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheUsersList', () {
    const tUsersListModel = UsersListModel(
      results: [
        UsersListResultsModel(
          name: UsersListResultsNameModel(
            title: "mr",
            first: "brad",
            last: "gibson",
          ),
          location: UsersListResultsLocationModel(
            street: UsersListResultsLocationStreetModel(
              number: 8554,
              name: 'street',
            ),
            city: "kilcoole",
            state: "waterford",
            postcode: 93027,
            coordinates: UsersListResultsLocationCoordinatesModel(
                latitude: "20.9267", longitude: "-7.9310"),
          ),
          picture: UsersListResultsPictureModel(
              large: "https://randomuser.me/api/portraits/men/75.jpg",
              medium: "https://randomuser.me/api/portraits/med/men/75.jpg",
              thumbnail:
                  "https://randomuser.me/api/portraits/thumb/men/75.jpg"),
        ),
      ],
    );

    test('cacheUsersList', () {
      // arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheUsersList(tUsersListModel);
      // assert
      final expectedJsonString = jsonEncode(tUsersListModel.toJson());
      verify(mockSharedPreferences.setString(
          cachedUsersList, expectedJsonString));
    });
  });
}
