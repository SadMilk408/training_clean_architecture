import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/features/auth/data/data_sources/login_local_data_source.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/data/repositories/login_repository_impl.dart';

class MockLocalDataSource extends Mock
    implements LoginLocalDataSource {}

void main(){
  late LoginRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = LoginRepositoryImpl(
      localDataSource: mockLocalDataSource
    );
  });

  const tLoginModel = LoginModel(username: 'username');

  test(
      'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastLogin())
            .thenAnswer((_) async => tLoginModel);
        // act
        final result = await repository.getLoginFromCache();
        // assert
        verify(mockLocalDataSource.getLastLogin());
        expect(result, equals(const Right(tLoginModel)));
      }
  );

  test(
      'should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastLogin())
            .thenThrow(CacheException());
        // act
        final result = await repository.getLoginFromCache();
        // assert
        verify(mockLocalDataSource.getLastLogin());
        expect(result, equals(Left(CacheFailure(message: 'cache failed'))));
      }
  );
}