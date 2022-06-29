import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/network.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_local_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_remote_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';
import 'package:training_clean_architecture/features/users_list/data/repositories/users_list_repository_impl.dart';


class MockRemoteDataSource extends Mock implements UsersListRemoteDataSource {}

class MockLocalDataSource extends Mock implements UsersListLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late UsersListRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UsersListRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getUsersList', () {
    const tPage = 1;
    const tResults = 10;
    const UsersListModel tUsersListModel =
      UsersListModel(
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
    final UsersListModel tUsersList = tUsersListModel;

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getUsersList(tPage, tResults);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getUsersList(any, any))
              .thenAnswer((_) async => tUsersListModel);
          // act
          final result = await repository.getUsersList(tPage, tResults);
          // assert
          verify(mockRemoteDataSource.getUsersList(tPage, tResults));
          expect(result, equals(Right(tUsersList)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getUsersList(any, any))
              .thenAnswer((_) async => tUsersListModel);
          // act
          await repository.getUsersList(tPage, tResults);
          // assert
          verify(mockRemoteDataSource.getUsersList(tPage, tResults));
          verify(mockLocalDataSource.cacheUsersList(tUsersListModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getUsersList(any, any))
              .thenThrow(ServerException(message: 'Ошибка сервера'));
          // act
          final result = await repository.getUsersList(tPage, tResults);
          // assert
          verify(mockRemoteDataSource.getUsersList(tPage, tResults));
          verifyZeroInteractions(mockLocalDataSource);
          expect(
              result, equals(left(ServerFailure(message: 'Ошибка сервера'))));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastUsersList())
              .thenAnswer((_) async => tUsersListModel);
          // act
          final result = await repository.getUsersList(tPage, tResults);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastUsersList());
          expect(result, equals(Right(tUsersList)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastUsersList())
              .thenThrow(CacheException());
          // act
          final result = await repository.getUsersList(tPage, tResults);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastUsersList());
          expect(result, equals(Left(CacheFailure(message: 'cache failed'))));
        },
      );
    });
  });
}
