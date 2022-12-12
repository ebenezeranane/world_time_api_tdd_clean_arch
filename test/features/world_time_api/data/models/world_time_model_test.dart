import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/models/world_time_model.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tWorldTimeModel = WorldTimeModel(
      datetime: "2022-12-10T18:25:15.772956+00:00", timezone: "Africa/Accra");

  test('should be a subclass of world time entity', () async {
    expect(tWorldTimeModel, isA<WorldTime>());
  });

  group('fromJson', () {
    test('should return a valid model when timezone is a string', () async {
      //Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture("world_time_api.json"));

      //Act
      final result = WorldTimeModel.fromJson(jsonMap);

      //Assert
      expect(result, tWorldTimeModel);
    });
  });

  group('toJson', () {
    test('should return a proper json Map', () async {
      //Arrange
      final result = tWorldTimeModel.toJson();

      //Act
      Map<String, dynamic> expectedJson = {
        "datetime": "2022-12-10T18:25:15.772956+00:00",
        "timezone": "Africa/Accra"
      };

      //Assert
      expect(result, expectedJson);
    });
  });
}
