import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

class FavoriteUsersModel {
  final UsersListResultsModel usersListModel;
  bool? favoriteFlag = false;

  FavoriteUsersModel({required this.usersListModel, this.favoriteFlag});
}