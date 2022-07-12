import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/domain/entities/login_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLoginMode = LoginModel(username: 'username');

  test('should be a subclass of LoginModel entity', () async {
    // assert
    expect(tLoginMode, isA<LoginEntity>());
  });
  
  group('fromJson', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('login.json'));
      // act
      final result = LoginModel.fromJson(jsonMap);
      // assert
      expect(result, tLoginMode);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tLoginMode.toJson();
      // assert
      final expectedMap = {
        'username': 'username',
      };
      expect(result, expectedMap);
    });
  });
}