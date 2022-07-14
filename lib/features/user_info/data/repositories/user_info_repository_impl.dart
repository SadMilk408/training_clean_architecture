import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/features/user_info/data/%20data_sources/user_info_local_data_source.dart';
import 'package:training_clean_architecture/features/user_info/domain/repositories/user_info_repository.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

class UserInfoRepositoryImpl implements UserInfoRepository {
  final UserInfoLocalDataSource localDataSource;

  UserInfoRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<UsersListResultsModel>>> getUsersInfoListFromCache() async {
    try {
      final listModel = await localDataSource.getUsersInfo();
      return Right(listModel);
    } on CacheException {
      return Left(CacheFailure(message: 'cache empty'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkUserInfoInCache(UsersListResultsModel usersListResultsModel) async {
    try {
      final listModel = await localDataSource.getUsersInfo();
      if(listModel.contains(usersListResultsModel)){
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on CacheException {
     return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserInfoToCache(UsersListResultsModel usersListResultsModel) async {
    try {
      final listModel = await localDataSource.getUsersInfo();
      if(listModel.contains(usersListResultsModel)){
        listModel.remove(usersListResultsModel);
        await localDataSource.cacheUserInfo(listModel);
        return Left(CacheFailure(message: 'delete user from favorite'));
      } else {
        listModel.add(usersListResultsModel);
        await localDataSource.cacheUserInfo(listModel);
        return const Right(true);
      }
    } on CacheException {
      localDataSource.cacheUserInfo([usersListResultsModel]);
      return const Right(true);
    }
  }
}