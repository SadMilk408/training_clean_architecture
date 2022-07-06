import 'dart:convert';
import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:training_clean_architecture/features/users_list/data/models/users_list_model.dart';
import 'package:training_clean_architecture/features/users_list/domain/entities/users_list_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUsersList = UsersListModel(
    results: [
      UsersListResultsModel(
        name: UsersListResultsNameModel(
          title: "mr",
          first: "brad",
          last: "gibson",
        ),
        location: UsersListResultsLocationModel(
          street: UsersListResultsLocationStreetModel(
            number: 8554,
            name: 'street',
          ),
          city: "kilcoole",
          state: "waterford",
          postcode: 93027,
          coordinates: UsersListResultsLocationCoordinatesModel(
            latitude: "20.9267",
            longitude: "-7.9310"
          ),
        ),
        picture: UsersListResultsPictureModel(
          large: "https://randomuser.me/api/portraits/men/75.jpg",
          medium: "https://randomuser.me/api/portraits/med/men/75.jpg",
          thumbnail: "https://randomuser.me/api/portraits/thumb/men/75.jpg"
        ),
      ),
    ],
  );

  test('should be a subclass of UserList entity', () async {
    // assert
    expect(tUsersList, isA<UsersListEntity>());
  });

  group('fromJson', () {
    test(
      'should return a valid models JSON',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('users_list.json'));
        // act
        final result = UsersListModel.fromJson(jsonMap);
        // assert
        expect(result, tUsersList);
      },
    );
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = tUsersList.toJson();
      // assert
      final expectedMap = {
        "results": [
          {
            "name": {
              "title": "mr",
              "first": "brad",
              "last": "gibson"
            },
            "location": {
              "street": "9278 new road",
              "city": "kilcoole",
              "state": "waterford",
              "postcode": "93027",
              "coordinates": {
                "latitude": "20.9267",
                "longitude": "-7.9310"
              }
            },
            "picture": {
              "large": "https://randomuser.me/api/portraits/men/75.jpg",
              "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
              "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg"
            }
          }
        ]
      };
      expect(result, expectedMap);
    });
  });
}
