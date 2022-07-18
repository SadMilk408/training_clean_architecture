import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/features/user_info/presentation/bloc/favorite_check_cubit/favorite_check_cubit.dart';
import 'package:training_clean_architecture/features/user_info/presentation/pages/user_info_page.dart';

class FloatingFavoriteButton extends StatelessWidget {
  const FloatingFavoriteButton({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final FavoritePage widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCheckCubit, FavoriteCheckState>(
      builder: (context, state) {
        if (state is FavoriteOffState) {
          return FloatingActionButton(
            backgroundColor: Colors.cyan,
            onPressed: () {
              context.read<FavoriteCheckCubit>().changeFavorite(widget.user);
            },
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 30,
            ),
          );
        } else if(state is FavoriteOnState) {
          return FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            onPressed: () {
              context.read<FavoriteCheckCubit>().changeFavorite(widget.user);
            },
            child: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}