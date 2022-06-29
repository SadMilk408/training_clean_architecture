import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/features/users_list/domain/entities/users_list_entity.dart';

abstract class UsersListRepository {
  Future<Either<Failure, UsersListEntity>>? getUsersList(int? page, int? results);
}