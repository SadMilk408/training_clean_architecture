import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

abstract class UserInfoRepository {
  Future<Either<Failure, UsersListModel>>? getUsersInfoListFromCache();
  Future<Either<Failure, bool>>? checkUserInfoInCache(UsersListResultsModel usersListResultsModel);
  Future<Either<Failure, bool>>? updateUserInfoToCache(UsersListResultsModel usersListResultsModel);
}