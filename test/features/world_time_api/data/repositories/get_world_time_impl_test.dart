import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:world_time_api_tdd_clean_arch/core/errors/exceptions.dart';
import 'package:world_time_api_tdd_clean_arch/core/errors/failures.dart';
import 'package:world_time_api_tdd_clean_arch/core/network/network_info.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/datasources/local_data_source.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/datasources/remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/models/world_time_model.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/repositories/get_world_time_impl.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';

class MockWorldTimeRemoteDataSource extends Mock
    implements WorldTimeRemoteDataSource {}

class MockWorldTimeLocalDataSource extends Mock
    implements WorldTimeLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockWorldTimeRemoteDataSource mockWorldTimeRemoteDataSource;
  MockWorldTimeLocalDataSource mockWorldTimeLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
  GetWorldTimeRepositoryImpl repository;

  setUp(() {
    mockWorldTimeRemoteDataSource = MockWorldTimeRemoteDataSource();
    mockWorldTimeLocalDataSource = MockWorldTimeLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GetWorldTimeRepositoryImpl(
        worldTimeRemoteDataSource: mockWorldTimeRemoteDataSource,
        worldTimeLocalDataSource: mockWorldTimeLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('when the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
    });

    body();
  }

  void runTestsOffline(body) {
    group('when the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });

    body();
  }

  group('getTime', () {
    // test variables
    final String tTimezone = "Accra/Ghana";
    final WorldTimeModel tWorldTimeModel = WorldTimeModel(
        datetime: "2022-12-10T18:25:15.772956+00:00", timezone: "Accra/Ghana");
    final WorldTime tWorldTime = tWorldTimeModel;

    test('should check if the device is online', () async {
      //Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //Act
      repository.getTime(tTimezone);

      //Assert
      verify(mockNetworkInfo.isConnected);
    });
    group('when the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'return remote data when the call to remote data source is successful',
          () async {
        //Arrange
        when(mockWorldTimeRemoteDataSource.getTime(any))
            .thenAnswer((_) async => tWorldTimeModel);
        //Act
        final result = await repository.getTime(tTimezone);
        expect(result, Right(tWorldTime));

        //Assert
        verify(mockWorldTimeRemoteDataSource.getTime(tTimezone));
      });

      test(
          'should cache  data when the call to remote data source is successful',
          () async {
        //Arrange
        when(mockWorldTimeRemoteDataSource.getTime(any))
            .thenAnswer((_) async => tWorldTimeModel);
        //Act
        await repository.getTime(tTimezone);

        //Assert
        verify(mockWorldTimeRemoteDataSource.getTime(tTimezone));
        verify(mockWorldTimeLocalDataSource.cacheTime(tWorldTimeModel));
      });

      test(
          'should return Server Failure when the call to remote data source is unsuccessful',
          () async {
        //Arrange
        when(mockWorldTimeRemoteDataSource.getTime(any))
            .thenThrow(ServerException());
        //Act
        final result = await repository.getTime(tTimezone);

        //Assert
        expect(result, equals(Left(ServerFailure())));
        verify(mockWorldTimeRemoteDataSource.getTime(tTimezone));

        // if call to remote data source is unsucessful then no caching is done
        verifyZeroInteractions(mockWorldTimeLocalDataSource);
      });
    });

    group('when the device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return last locally cached data when cache data is present',
          () async {
        //Arrange
        when(mockWorldTimeLocalDataSource.getLastTime())
            .thenAnswer((_) async => tWorldTimeModel);
        //Act
        final result = await repository.getTime(tTimezone);

        verify(mockWorldTimeLocalDataSource.getLastTime());

        verifyZeroInteractions(mockWorldTimeRemoteDataSource);

        //Assert
        expect(result, equals(Right(tWorldTimeModel)));
      });

      test('should throw a cache exception  when cache data is not present',
          () async {
        //Arrange
        when(mockWorldTimeLocalDataSource.getLastTime())
            .thenThrow(CacheException());
        //Act
        final result = await repository.getTime(tTimezone);

        verify(mockWorldTimeLocalDataSource.getLastTime());

        verifyZeroInteractions(mockWorldTimeRemoteDataSource);

        //Assert
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
