import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/usecases/usecase.dart';
import 'package:training_clean_architecture/features/user_info/domain/repositories/user_info_repository.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/check_user_info.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/get_users_info_list.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/update_user_info.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';
import 'user_info_test.mocks.dart';

@GenerateMocks([UserInfoRepository])
void main(){
  late CheckUserInfo checkUserInfoUsecase;
  late GetUsersInfoList getUsersInfoListUsecase;
  late UpdateUserInfo updateUserInfoUsecase;
  late MockUserInfoRepository mockUserInfoRepository;

  setUp(() {
    mockUserInfoRepository = MockUserInfoRepository();
    checkUserInfoUsecase = CheckUserInfo(mockUserInfoRepository);
    getUsersInfoListUsecase = GetUsersInfoList(mockUserInfoRepository);
    updateUserInfoUsecase = UpdateUserInfo(mockUserInfoRepository);
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

  test('should get users info from the repository', () async {
    // arrange
    when(mockUserInfoRepository.getUsersInfoListFromCache())
        .thenAnswer((_) async => const Right(tUserInfoModel));
    // act
    final result =
      await getUsersInfoListUsecase(NoParams());
    // assert
    expect(result, const Right(tUserInfoModel));
    verify(mockUserInfoRepository.getUsersInfoListFromCache());
    verifyNoMoreInteractions(mockUserInfoRepository);
  });

  // test('should return true if user info in cache', () async {
  //   // arrange
  //   when(mockUserInfoRepository.checkUserInfoInCache(any))
  //       .thenAnswer((_) async => const Right(true));
  //   // act
  //   final result =
  //       await checkUserInfoUsecase(tUserInfo);
  //   // assert
  //   expect(result, const Right(true));
  //   verify(mockUserInfoRepository.checkUserInfoInCache(tUserInfo));
  //   verifyNoMoreInteractions(mockUserInfoRepository);
  // });
  //
  // test('should return failure if user info cache failed', () async {
  //   // arrange
  //   when(mockUserInfoRepository.checkUserInfoInCache(any))
  //       .thenAnswer((_) async => Left(CacheFailure(message: 'cache empty')));
  //   // act
  //   final result = await checkUserInfoUsecase(tUserInfo);
  //   // assert
  //   expect(result, Left(CacheFailure(message: 'cache empty')));
  //   verify(mockUserInfoRepository.checkUserInfoInCache(tUserInfo));
  //   verifyNoMoreInteractions(mockUserInfoRepository);
  // });

  // test('should return true if user info in cache', () async {
  //   // arrange
  //   when(mockUserInfoRepository.updateUserInfoToCache(any))
  //       .thenAnswer((_) async => const Right(true));
  //   // act
  //   final result =
  //       await updateUserInfoUsecase(tUserInfo);
  //   // assert
  //   expect(result, const Right(true));
  //   verify(mockUserInfoRepository.updateUserInfoToCache(tUserInfo));
  //   verifyNoMoreInteractions(mockUserInfoRepository);
  // });
}