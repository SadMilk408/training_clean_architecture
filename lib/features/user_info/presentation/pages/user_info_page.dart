import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/features/user_info/presentation/bloc/favorite_check_cubit/favorite_check_cubit.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

class FavoritePage extends StatefulWidget {
  final UsersListResultsModel user;

  const FavoritePage({Key? key, required this.user}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCheckCubit>().checkFavoriteInCache(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Пользователь'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Column(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  /*Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GeoMap(
                        coordinates: widget.user.location!.coordinates!,
                      ),
                    ),
                  );*/
                },
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                    widget.user.picture!.large,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.user.name!.title} ${widget.user.name!.first} ${widget.user.name!.last}',
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${widget.user.location!.city}, ${widget.user.location!.street.number} ${widget.user.location!.street.name}',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<FavoriteCheckCubit, FavoriteCheckState>(
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
      ),
    );
  }
}
