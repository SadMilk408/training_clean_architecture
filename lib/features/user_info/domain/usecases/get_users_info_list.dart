import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/usecases/usecase.dart';
import 'package:training_clean_architecture/features/user_info/domain/repositories/user_info_repository.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

class GetUsersInfoList implements UseCase<UsersListModel, NoParams> {
  final UserInfoRepository repository;

  GetUsersInfoList(this.repository);

  @override
  Future<Either<Failure, UsersListModel>?> call(NoParams) async {
    return await repository.getUsersInfoListFromCache();
  }
}