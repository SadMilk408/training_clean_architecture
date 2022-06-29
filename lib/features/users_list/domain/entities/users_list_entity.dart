import 'package:equatable/equatable.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';

class UsersListEntity extends Equatable {
	final List<UsersListResultsModel>? results;
  
  const UsersListEntity({required this.results});

  @override
  List<Object?> get props => [results];
}

class UsersListResults extends Equatable {
  final UsersListResultsNameModel? name;
  final UsersListResultsLocationModel? location;
  final UsersListResultsPictureModel? picture;

  const UsersListResults({required this.name, required this.location, required this.picture});

  @override
  List<Object?> get props => [name, location, picture];
}

class UsersListResultsName extends Equatable {
  final String title;
  final String first;
  final String last;

  const UsersListResultsName({required this.title, required this.first, required this.last});

  @override
  List<Object?> get props => [title, first, last];
}

class UsersListResultsLocation extends Equatable {
  final UsersListResultsLocationStreetModel street;
  final String city;
  final String state;
  final dynamic postcode;
  final UsersListResultsLocationCoordinatesModel coordinates;

  const UsersListResultsLocation({required this.street, required this.city, required this.state, required this.postcode, required this.coordinates});

  @override
  List<Object?> get props => [street, city, state, postcode, coordinates];
}

class UsersListResultsLocationStreet extends Equatable {
  final int number;
  final String name;

  const UsersListResultsLocationStreet({required this.number, required this.name});

  @override
  List<Object?> get props => [number, name];
}

class UsersListResultsLocationCoordinates extends Equatable {
  final String latitude;
  final String longitude;

  const UsersListResultsLocationCoordinates({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}

class UsersListResultsPicture extends Equatable {
  final String large;
  final String medium;
  final String thumbnail;

  const UsersListResultsPicture({required this.large, required this.medium, required this.thumbnail});

  @override
  List<Object?> get props => [large, medium, thumbnail];
}