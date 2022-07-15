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
  Future<Either<Failure, UsersListModel>>? getUsersInfoListFromCache() async {
    try {
      final listModel = await localDataSource.getUsersInfo();
      return Right(listModel!);
    } on CacheException {
      return Left(CacheFailure(message: 'cache empty'));
    }
  }

  @override
  Future<Either<Failure, bool>>? checkUserInfoInCache(UsersListResultsModel usersListResultsModel) async {
    try {
      final listModel = await localDataSource.getUsersInfo();
      if(listModel!.results!.contains(usersListResultsModel)){
        return const Right(true);
      } else {
        return Left(CacheFailure());
      }
    } on CacheException {
     return Left(CacheFailure(message: 'cache empty'));
    }
  }

  @override
  Future<Either<Failure, bool>>? updateUserInfoToCache(UsersListResultsModel usersListResultsModel) async {
    try {
      final listModel = await localDataSource.getUsersInfo();
      if(listModel!.results!.contains(usersListResultsModel)){
        listModel.results!.remove(usersListResultsModel);
        await localDataSource.cacheUsersInfo(listModel);
        return Left(CacheFailure(message: 'user info delete from cache'));
      } else {
        listModel.results!.add(usersListResultsModel);
        await localDataSource.cacheUsersInfo(listModel);
        return const Right(true);
      }
    } on CacheException {
      final listModel = UsersListModel(results: [usersListResultsModel]);
      await localDataSource.cacheUsersInfo(listModel);
      return const Right(true);
    }
  }
}