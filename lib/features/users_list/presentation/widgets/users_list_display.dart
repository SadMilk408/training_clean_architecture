import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/features/user_info/data/models/favorite_users_model.dart';
import 'package:training_clean_architecture/features/user_info/presentation/bloc/favorite_check_cubit/favorite_check_cubit.dart';
import 'package:training_clean_architecture/features/user_info/presentation/pages/user_info_page.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';
import 'package:training_clean_architecture/features/users_list/presentation/bloc/users_list_bloc.dart';
import 'package:training_clean_architecture/injection_container.dart';

class UsersListDisplay extends StatefulWidget {
  final List<FavoriteUsersModel> usersList;

  const UsersListDisplay({Key? key, required this.usersList}) : super(key: key);

  @override
  State<UsersListDisplay> createState() => _UsersListDisplayState();
}

class _UsersListDisplayState extends State<UsersListDisplay> {
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int pageCount = 1;

  Future<void> _onRefresh() async {
    context.read<UsersListBloc>().add(const UsersListLoadingEvent(1, 20));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: scrollController,
        itemCount: widget.usersList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => sl<FavoriteCheckCubit>(),
                      child: FavoritePage(
                        user: widget.usersList[index].usersListModel,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.blue.withOpacity(0.5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.usersList[index].usersListModel.picture!.medium,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        '${widget.usersList[index].usersListModel.name!.first} ${widget.usersList[index].usersListModel.name!.last}',
                      ),
                    ],
                  ),
                  trailing: BlocProvider(
                    create: (context) => sl<FavoriteCheckCubit>(),
                    child: FavoriteTrailing(usersListResultsModel: widget.usersList[index].usersListModel,),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FavoriteTrailing extends StatefulWidget {
  final UsersListResultsModel usersListResultsModel;

  const FavoriteTrailing({
    Key? key,
    required this.usersListResultsModel,
  }) : super(key: key);

  @override
  State<FavoriteTrailing> createState() => _FavoriteTrailingState();
}

class _FavoriteTrailingState extends State<FavoriteTrailing> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCheckCubit>().checkFavoriteInCache(widget.usersListResultsModel);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCheckCubit, FavoriteCheckState>(
      builder: (context, state) {
        if (state is FavoriteOffState) {
          return IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: (){
              context.read<FavoriteCheckCubit>().changeFavorite(widget.usersListResultsModel);
            },
          );
        } else if(state is FavoriteOnState) {
          return IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: (){
              context.read<FavoriteCheckCubit>().changeFavorite(widget.usersListResultsModel);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
