part of 'favorite_check_cubit.dart';

@immutable
abstract class FavoriteCheckState {}

class FavoriteCheckInitial extends FavoriteCheckState {}

class FavoriteOnState extends FavoriteCheckState {}
class FavoriteOffState extends FavoriteCheckState {}
