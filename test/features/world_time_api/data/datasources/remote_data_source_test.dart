import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:world_time_api_tdd_clean_arch/core/errors/exceptions.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/datasources/remote_data_source.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/models/world_time_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  WorldRemoteDataSourceImpl worldRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    worldRemoteDataSourceImpl =
        WorldRemoteDataSourceImpl(client: mockHttpClient);
  });

  setUpMockClientSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('world_time_api.json'), 200));
  }

  group('getTime', () {
    final tTimezone = "Accra/Ghana";
    final tWorldTimeModel =
        WorldTimeModel.fromJson(jsonDecode(fixture("world_time_api.json")));

    test('''should perform a GET request on URL with timezone
        being the endpoint and application/json being the header''', () async {
      //Arrange
      setUpMockClientSuccess();
      //Act
      worldRemoteDataSourceImpl.getTime(tTimezone);

      //Assert
      verify(mockHttpClient.get(
          "https://worldtimeapi.org/api/timezone/$tTimezone",
          headers: {"Content-Type": "application/json"}));
    });

    test(
        'should return a WorldTime model when the status code is 200(successful)',
        () async {
      //Arrange
      setUpMockClientSuccess();

      //Act
      final result = await worldRemoteDataSourceImpl.getTime(tTimezone);

      expect(result, equals(tWorldTimeModel));
      //Assert
    });

    test(
        'should throw a Server Exception when the status code is 404(unsuccessful)',
        () async {
      //Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response("Something went wrong", 404));

      //Act
      final call = worldRemoteDataSourceImpl.getTime;

      expect(() => call(tTimezone), throwsA(TypeMatcher<ServerException>()));
      //Assert
    });
  });
}
