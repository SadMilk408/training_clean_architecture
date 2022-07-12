import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/set_user_info.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

part 'favorite_check_state.dart';

class FavoriteCheckCubit extends Cubit<FavoriteCheckState> {
  late SetUserInfo setUserInfo;

  FavoriteCheckCubit({
    required this.setUserInfo,
  }) : super(FavoriteCheckInitial());

  changeFavorite(UsersListResultsModel usersListResultsModel) async {
    final failureOrCached = await setUserInfo(usersListResultsModel);
    failureOrCached?.fold(
      (failure) => null,
      (cached) => emit(FavoriteCheckChangeState()),
    );
  }
}
