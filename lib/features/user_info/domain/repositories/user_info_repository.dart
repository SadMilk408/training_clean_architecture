import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

abstract class UserInfoRepository {
  // TODO: Добавить ф-ю для проверки наличия в кеше одного юзера
  Future<Either<Failure, List<UsersListResultsModel>>>? getUsersInfoListFromCache();
  Future<Either<Failure, bool>>? updateUserInfoToCache(UsersListResultsModel usersListResultsModel);
}