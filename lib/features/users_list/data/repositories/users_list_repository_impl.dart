import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/network.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_local_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_remote_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';
import 'package:training_clean_architecture/features/users_list/domain/entities/users_list_entity.dart';
import 'package:training_clean_architecture/features/users_list/domain/repositories/users_list_repository.dart';

class UsersListRepositoryImpl implements UsersListRepository {
  final UsersListRemoteDataSource remoteDataSource;
  final UsersListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UsersListRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UsersListEntity>> getUsersList(
    int? page,
    int? results,
  ) async {
    if (await networkInfo.isConnected ?? false) {
      try {
        final remoteTrivia = await remoteDataSource.getUsersList(page, results);
        localDataSource.cacheUsersList(remoteTrivia);
        return Right(remoteTrivia ?? const UsersListModel(results: []));
      } on ServerException {
        return Left(ServerFailure(message: 'Ошибка сервера'));
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastUsersList();
        return Right(localTrivia ?? const UsersListModel(results: []));
      } on CacheException {
        return Left(CacheFailure(message: 'cache failed'));
      }
    }
  }
}
