import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>>? getLoginFromCache();
  Future<Either<Failure, bool>>? setLoginToCache(LoginModel loginModel);
}