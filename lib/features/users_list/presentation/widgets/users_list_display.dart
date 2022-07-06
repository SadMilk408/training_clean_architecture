import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/features/users_list/domain/entities/users_list_entity.dart';
import 'package:training_clean_architecture/features/users_list/presentation/bloc/users_list_bloc.dart';

class UsersListDisplay extends StatefulWidget {
  final UsersListEntity usersList;

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
        itemCount: widget.usersList.results!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                /*Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => FavoriteCheckCubit(),
                        child: UserInfo(
                          user: users[index],
                        ),
                      ),
                    ),
                  );*/
              },
              child: Container(
                color: Colors.blue.withOpacity(0.5),
                child: ListTile(
                  leading: Hero(
                    tag: '$index',
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.usersList.results![index].picture!.medium,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        '${widget.usersList.results![index].name!.first} ${widget.usersList.results![index].name!.last}',
                      ),
                    ],
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
