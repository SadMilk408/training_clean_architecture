import 'package:dartz/dartz.dart';
import 'package:training_clean_architecture/core/errors/exceptions.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/features/auth/data/data_sources/login_local_data_source.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/domain/entities/login_entity.dart';
import 'package:training_clean_architecture/features/auth/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, LoginEntity>>? getLoginFromCache() async {
    try {
      final localLogin = await localDataSource.getLastLogin();
      return Right(localLogin ?? const LoginModel(username: ''));
    } on CacheException {
      return Left(CacheFailure(message: 'cache failure'));
    }
  }

  @override
  Future<Either<Failure, bool>>? setLoginToCache(String username) async {
    try{
      await localDataSource.cacheLogin(LoginModel(username: username));
      return const Right(true);
    } on CacheException {
      return Left(CacheFailure(message: 'cache failure'));
    }
  }
}