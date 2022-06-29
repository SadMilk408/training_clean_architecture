import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:training_clean_architecture/features/users_list/presentation/bloc/users_list_bloc.dart';
import 'package:training_clean_architecture/features/users_list/presentation/widgets/widgets.dart';
import 'package:training_clean_architecture/injection_container.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<UsersListBloc> buildBody(context) {
    return BlocProvider(
      create: (context) => sl<UsersListBloc>()..add(const UsersListLoadingEvent(1, 20)),
      child: BlocBuilder<UsersListBloc, UsersListState>(
        builder: (context, state){
          if(state is LoadingState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is ErrorState){
            return MessageDisplay(message: state.message,);
          } else if(state is DoneState){
            if(state.usersList.results != null){
              return UsersListDisplay(usersList: state.usersList,);
            }
          }
          return const SizedBox.shrink();
        },
      )
    );
  }
}
