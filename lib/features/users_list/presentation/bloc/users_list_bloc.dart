import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/core/usecases/usecase.dart';
import 'package:training_clean_architecture/features/user_info/data/models/favorite_users_model.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/get_users_info_list.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';
import 'package:training_clean_architecture/features/users_list/domain/entities/users_list_entity.dart';
import 'package:training_clean_architecture/features/users_list/domain/usecases/get_users_list.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  late GetUsersList getUsersList;
  late GetUsersInfoList getUsersInfoList;

  UsersListBloc({
    required this.getUsersList,
    required this.getUsersInfoList,
  }) : super(EmptyState()) {

    List<FavoriteUsersModel> list = [];

    on<UsersListLoadingEvent>((event, emit) async {
      emit(LoadingState());
      final failureOrSuccessCachedUsers =
          await getUsersInfoList(NoParams());
      failureOrSuccessCachedUsers?.fold(
          (failure) {},
          (r) {
            // list = r.results!;
            for (var element in r.results!) {
              list.add(FavoriteUsersModel(usersListModel: element, favoriteFlag: true));
            }
          }
      );

      final failureOrSuccess =
          await getUsersList(Params(page: event.page, results: event.results));
      failureOrSuccess?.fold(
          (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
          (r) {
            for (var element in r.results!) {
              list.add(FavoriteUsersModel(usersListModel: element));
            }
            emit(DoneState(usersListWithFavorites: list));
          });
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
