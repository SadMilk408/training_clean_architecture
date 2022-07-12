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
  Future<Either<Failure, bool>> setUserInfoToCache(UsersListResultsModel usersListResultsModel) async {
    try {
      await localDataSource.cacheUserInfo(usersListResultsModel);
      return const Right(true);
    } on CacheException {
      return Left(CacheFailure(message: 'cache failure'));
    }
  }

  @override
  Future<Either<Failure, bool>>? deleteUserInfoFromCache(UsersListResultsModel usersListResultsModel) {
    // TODO: implement deleteUserInfoFromCache
    throw UnimplementedError();
  }
}