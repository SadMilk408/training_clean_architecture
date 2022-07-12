// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersListModel _$UsersListModelFromJson(Map<String, dynamic> json) =>
    UsersListModel(
      results: (json['results'] as List<dynamic>)
          .map((e) => UsersListResultsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsersListModelToJson(UsersListModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('results', instance.results?.map((e) => e.toJson()).toList());
  return val;
}

UsersListResultsModel _$UsersListResultsModelFromJson(
        Map<String, dynamic> json) =>
    UsersListResultsModel(
      name: UsersListResultsNameModel.fromJson(
          json['name'] as Map<String, dynamic>),
      location: UsersListResultsLocationModel.fromJson(
          json['location'] as Map<String, dynamic>),
      picture: UsersListResultsPictureModel.fromJson(
          json['picture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsersListResultsModelToJson(
    UsersListResultsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name?.toJson());
  writeNotNull('location', instance.location?.toJson());
  writeNotNull('picture', instance.picture?.toJson());
  return val;
}

UsersListResultsNameModel _$UsersListResultsNameModelFromJson(
        Map<String, dynamic> json) =>
    UsersListResultsNameModel(
      title: json['title'] as String,
      first: json['first'] as String,
      last: json['last'] as String,
    );

Map<String, dynamic> _$UsersListResultsNameModelToJson(
        UsersListResultsNameModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'first': instance.first,
      'last': instance.last,
    };

UsersListResultsLocationModel _$UsersListResultsLocationModelFromJson(
        Map<String, dynamic> json) =>
    UsersListResultsLocationModel(
      street: UsersListResultsLocationStreetModel.fromJson(
          json['street'] as Map<String, dynamic>),
      city: json['city'] as String,
      state: json['state'] as String,
      postcode: json['postcode'],
      coordinates: UsersListResultsLocationCoordinatesModel.fromJson(
          json['coordinates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsersListResultsLocationModelToJson(
    UsersListResultsLocationModel instance) {
  final val = <String, dynamic>{
    'street': instance.street.toJson(),
    'city': instance.city,
    'state': instance.state,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('postcode', instance.postcode);
  val['coordinates'] = instance.coordinates.toJson();
  return val;
}

UsersListResultsLocationStreetModel
    _$UsersListResultsLocationStreetModelFromJson(Map<String, dynamic> json) =>
        UsersListResultsLocationStreetModel(
          number: json['number'] as int,
          name: json['name'] as String,
        );

Map<String, dynamic> _$UsersListResultsLocationStreetModelToJson(
        UsersListResultsLocationStreetModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
    };

UsersListResultsLocationCoordinatesModel
    _$UsersListResultsLocationCoordinatesModelFromJson(
            Map<String, dynamic> json) =>
        UsersListResultsLocationCoordinatesModel(
          latitude: json['latitude'] as String,
          longitude: json['longitude'] as String,
        );

Map<String, dynamic> _$UsersListResultsLocationCoordinatesModelToJson(
        UsersListResultsLocationCoordinatesModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

UsersListResultsPictureModel _$UsersListResultsPictureModelFromJson(
        Map<String, dynamic> json) =>
    UsersListResultsPictureModel(
      large: json['large'] as String,
      medium: json['medium'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$UsersListResultsPictureModelToJson(
        UsersListResultsPictureModel instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'thumbnail': instance.thumbnail,
    };
