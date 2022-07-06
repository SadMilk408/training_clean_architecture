import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/usecases/usecase.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/domain/entities/login_entity.dart';
import 'package:training_clean_architecture/features/auth/domain/repositories/login_repository.dart';

class GetLogin implements UseCase<LoginEntity, NoParams> {
  final LoginRepository repository;

  GetLogin(this.repository);

  @override
  Future<Either<Failure, LoginEntity>?> call(NoParams) async {
    return await repository.getLoginFromCache();
  }
}

class SetLogin implements UseCase<bool, LoginModel> {
  final LoginRepository repository;

  SetLogin(this.repository);

  @override
  Future<Either<Failure, bool>?> call(LoginModel loginModel) async {
    return await repository.setLoginToCache(loginModel.username);
  }
}