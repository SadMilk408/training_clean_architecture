import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:training_clean_architecture/core/dictionaries/constants.dart';
import 'package:training_clean_architecture/core/errors/failures.dart';
import 'package:training_clean_architecture/features/users_list/domain/entities/users_list_entity.dart';
import 'package:training_clean_architecture/features/users_list/domain/usecases/get_users_list.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  late GetUsersList getUsersList;

  UsersListBloc({
    required this.getUsersList,
  }) : super(EmptyState()) {
    on<UsersListLoadingEvent>((event, emit) async {
      emit(LoadingState());
      final failureOrSuccess =
          await getUsersList(Params(page: event.page, results: event.results));
      failureOrSuccess?.fold(
          (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
          (r) => emit(DoneState(usersList: r)));
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
