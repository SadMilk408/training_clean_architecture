import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';
import 'package:training_clean_architecture/features/users_list/domain/entities/users_list_entity.dart';
import 'package:training_clean_architecture/features/users_list/domain/repositories/users_list_repository.dart';
import 'package:training_clean_architecture/features/users_list/domain/usecases/get_users_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_users_list_test.mocks.dart';

@GenerateMocks([UsersListRepository])
void main() {
  late GetUsersList usecase;
  late MockUsersListRepository mockUsersListRepository;

  setUp(() {
    mockUsersListRepository = MockUsersListRepository();
    usecase = GetUsersList(mockUsersListRepository);
  });

  const tPageNum = 1;
  const tResultsNum = 10;
  const tUsersList = UsersListEntity(
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

  test('should get list of users from the repository', () async {
    // arrange
    when(mockUsersListRepository.getUsersList(any, any))
        .thenAnswer((_) async => const Right(tUsersList));
    // act
    final result =
        await usecase(const Params(page: tPageNum, results: tResultsNum));
    // assert
    expect(result, const Right(tUsersList));
    verify(mockUsersListRepository.getUsersList(tPageNum, tResultsNum));
    verifyNoMoreInteractions(mockUsersListRepository);
  });
}
