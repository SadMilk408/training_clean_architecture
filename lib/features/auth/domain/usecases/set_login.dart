import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/usecases/usecase.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/domain/repositories/login_repository.dart';

class SetLogin implements UseCase<bool, LoginModel> {
  final LoginRepository repository;

  SetLogin(this.repository);

  @override
  Future<Either<Failure, bool>?> call(LoginModel loginModel) async {
    return await repository.setLoginToCache(loginModel);
  }
}