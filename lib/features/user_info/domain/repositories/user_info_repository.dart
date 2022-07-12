import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

abstract class UserInfoRepository {
  Future<Either<Failure, bool>>? setUserInfoToCache(UsersListResultsModel usersListResultsModel);
  Future<Either<Failure, bool>>? deleteUserInfoFromCache(UsersListResultsModel usersListResultsModel);
}