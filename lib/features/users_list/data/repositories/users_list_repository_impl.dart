import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/network/network.dart';
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
    try {
      final localUsers = await localDataSource.getLastUsersList();
      return Right(localUsers!);
    } on CacheException {
      if (await networkInfo.isConnected ?? false) {
        try {
          final remoteTrivia = await remoteDataSource.getUsersList(page, results);
          localDataSource.cacheUsersList(remoteTrivia);
          return Right(remoteTrivia ?? const UsersListModel(results: []));
        } on ServerException {
          return Left(ServerFailure(message: 'Server failed'));
        }
      } else {
        return Left(CacheFailure(message: 'cache failed'));
      }
    }
  }
}
