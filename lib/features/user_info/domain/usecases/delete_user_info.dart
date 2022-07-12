import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/usecases/usecase.dart';
import 'package:training_clean_architecture/features/user_info/domain/repositories/user_info_repository.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

class DeleteUserInfo implements UseCase<bool, UsersListResultsModel> {
  final UserInfoRepository repository;

  DeleteUserInfo(this.repository);

  @override
  Future<Either<Failure, bool>?> call(UsersListResultsModel usersListResultsModel) async {
    return await repository.setUserInfoToCache(usersListResultsModel);
  }
}