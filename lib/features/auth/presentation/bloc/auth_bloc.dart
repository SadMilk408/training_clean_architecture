import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:training_clean_architecture/core/usecases/usecase.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/domain/usecases/login_use_case.dart';
import 'package:training_clean_architecture/features/users_list/presentation/pages/users_list_page.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late GetLogin getLogin;
  late SetLogin setLogin;

  AuthBloc({required this.getLogin, required this.setLogin})
      : super(AuthInitial()) {
    on<AutoAuthEvent>((event, emit) async {
      final failureOrLogin = await getLogin(NoParams());
      failureOrLogin?.fold(
        (failure) => null,
        (login) {
          Navigator.of(event.context).pushReplacement(MaterialPageRoute(
            builder: (context) => UsersListPage(),
          ));
        },
      );
    });

    on<SaveLoginToCacheEvent>((event, emit) async {
      final failureOrCached = await setLogin(event.loginModel);
      failureOrCached?.fold(
        (failure) => null,
        (cached) {
          Navigator.of(event.context).pushReplacement(MaterialPageRoute(
            builder: (context) => UsersListPage(),
          ));
        },
      );
    });
  }
}
