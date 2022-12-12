import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:world_time_api_tdd_clean_arch/core/errors/exceptions.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/datasources/local_data_source.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/models/world_time_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  WorldTimeLocalDataSourceImpl worldTimeLocalDataSource;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    worldTimeLocalDataSource =
        WorldTimeLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastTime', () {
    final tWorldTimeModel = WorldTimeModel.fromJson(
        jsonDecode(fixture('world_time_local_data.json')));
    test(
        'should return a NumberTrivia from SharedPreferences when there is one in Cache',
        () async {
      //Arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('world_time_local_data.json'));
      //Act
      final result = await worldTimeLocalDataSource.getLastTime();

      expect(result, tWorldTimeModel);
      //Assert

      verify(mockSharedPreferences.getString('CACHED_TIME'));
    });

    test('should return a CacheException when there is none present in Cache',
        () async {
      //Arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //Act
      final call = worldTimeLocalDataSource.getLastTime;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      //Assert
    });
  });

  group('CacheTime', () {
    final tWorldTimeModel = WorldTimeModel(
        datetime: "2022-12-10T18:25:15.772956+00:00", timezone: "Accra/Ghana");
    test('should cache time to shared preferences', () async {
      //Arrange

      //Act
      worldTimeLocalDataSource.cacheTime(tWorldTimeModel);

      //Assert
      final expectedJson = jsonEncode(tWorldTimeModel.toJson());
      verify(mockSharedPreferences.setString("CACHED_TIME", expectedJson));
    });
  });
}
