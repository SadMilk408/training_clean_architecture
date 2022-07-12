import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/usecases/usecase.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/domain/repositories/login_repository.dart';
import 'package:training_clean_architecture/features/auth/domain/usecases/get_login.dart';
import 'package:training_clean_architecture/features/auth/domain/usecases/set_login.dart';

import 'login_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late GetLogin getLoginUsecase;
  late SetLogin setLoginUsecase;
  late MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    getLoginUsecase = GetLogin(mockLoginRepository);
    setLoginUsecase = SetLogin(mockLoginRepository);
  });

  const tLoginModel = LoginModel(username: 'username');

  test('should get login of user from the repository', () async {
    // arrange
    when(mockLoginRepository.getLoginFromCache())
        .thenAnswer((_) async => const Right(tLoginModel));
    // act
    final result = await getLoginUsecase(NoParams());
    // assert
    expect(result, const Right(tLoginModel));
    verify(mockLoginRepository.getLoginFromCache());
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test('should return true if login cache successful', () async {
    // arrange
    when(mockLoginRepository.setLoginToCache(any))
        .thenAnswer((_) async => const Right(true));
    // act
    final result = await setLoginUsecase(tLoginModel);
    // assert
    expect(result, const Right(true));
    verify(mockLoginRepository.setLoginToCache(tLoginModel));
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test('should return failure if login cache failed', () async {
    // arrange
    when(mockLoginRepository.setLoginToCache(any))
        .thenAnswer((_) async => Left(CacheFailure(message: 'cache failure')));
    // act
    final result = await setLoginUsecase(tLoginModel);
    // assert
    expect(result, Left(CacheFailure(message: 'cache failure')));
    verify(mockLoginRepository.setLoginToCache(tLoginModel));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
