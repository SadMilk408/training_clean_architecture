// Mocks generated by Mockito 5.2.0 from annotations
// in training_clean_architecture/test/features/auth/domain/usecases/login_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:training_clean_architecture/core/errors/failures.dart' as _i5;
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/domain/repositories/login_repository.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [LoginRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRepository extends _i1.Mock implements _i2.LoginRepository {
  MockLoginRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, bool>>? setLoginToCache(LoginModel? login) =>
      (super.noSuchMethod(Invocation.method(#setLoginToCache, [login]))
          as _i3.Future<_i4.Either<_i5.Failure, bool>>?);
}
