import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/features/user_info/presentation/bloc/favorite_check_cubit/favorite_check_cubit.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

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