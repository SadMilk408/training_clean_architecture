import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/check_user_info.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/update_user_info.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

part 'favorite_check_state.dart';

class FavoriteCheckCubit extends Cubit<FavoriteCheckState> {
  late UpdateUserInfo updateUserInfo;
  late CheckUserInfo checkUserInfo;

  FavoriteCheckCubit({
    required this.updateUserInfo,
    required this.checkUserInfo,
  }) : super(FavoriteCheckInitial());

  // TODO: сделать ф-ю для проверки находиться ли юзер в кеше, если да то идет в [FavoriteOnState()]
  checkFavoriteInCache(UsersListResultsModel usersListResultsModel) async {
    final failureOrCache = await checkUserInfo(usersListResultsModel);
    failureOrCache.fold((l) => null, (r) => null);
  }

  changeFavorite(UsersListResultsModel usersListResultsModel) async {
    final failureOrCached = await updateUserInfo(usersListResultsModel);
    failureOrCached.fold(
      (failure) => emit(FavoriteOffState()),
      (cached) => emit(FavoriteOnState()),
    );
  }
}
