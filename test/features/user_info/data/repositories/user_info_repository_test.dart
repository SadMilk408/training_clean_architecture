import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_clean_architecture/features/user_info/data/%20data_sources/user_info_local_data_source.dart';
import 'package:training_clean_architecture/features/user_info/data/repositories/user_info_repository_impl.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_local_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

class MockLocalDataSource extends Mock
    implements UserInfoLocalDataSource {}

class MockLocalAllUsersDataSource extends Mock
    implements UsersListLocalDataSource {}

void main(){
  late UserInfoRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;
  late MockLocalAllUsersDataSource mockLocalAllUsersDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockLocalAllUsersDataSource = MockLocalAllUsersDataSource();
    repository = UserInfoRepositoryImpl(localDataSource: mockLocalDataSource, localAllUsersDataSource: mockLocalAllUsersDataSource);
  });

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

  test(
      'should get user info list in cached',
          () async {
        // arrange
        when(mockLocalDataSource.getUsersInfo())
            .thenAnswer((_) async => tUserInfoModel);
        // act
        final result = await repository.getUsersInfoListFromCache();
        // assert
        verify(mockLocalDataSource.getUsersInfo());
        expect(result, equals(const Right(tUserInfoModel)));
      }
  );

  test(
    'should check entry user info in cache if cache not empty',
      () async {
        // arrange
        when(mockLocalDataSource.getUsersInfo())
            .thenAnswer((_) async => tUserInfoModel);
        // act
        final result = await repository.checkUserInfoInCache(tUserInfoModel.results![0]);
        // assert
        verify(mockLocalDataSource.getUsersInfo());
        expect(result, equals(const Right(true)));
      }
  );

  test(
      'should throw exp if cache empty',
          () async {
        // arrange
        when(mockLocalDataSource.getUsersInfo())
            .thenAnswer((_) async => tUserInfoModel);
        // act
        final result = await repository.checkUserInfoInCache(tUserInfoModel.results![0]);
        // assert
        verify(mockLocalDataSource.getUsersInfo());
        expect(result, equals(const Right(true)));
      }
  );
}