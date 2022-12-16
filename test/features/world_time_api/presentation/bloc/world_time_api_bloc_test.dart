import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:world_time_api_tdd_clean_arch/core/errors/failures.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/usecases/get_world_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/presentation/bloc/world_time_api_bloc.dart';

class MockGetWorldTime extends Mock implements GetWorldTime {}

void main() {
  MockGetWorldTime mockGetWorldTime;
  WorldTimeApiBloc bloc;

  setUp(() {
    mockGetWorldTime = MockGetWorldTime();
    bloc = WorldTimeApiBloc(getWorldTime: mockGetWorldTime);
  });

  test('initial state should be empty ', () async {
    expect(
      bloc.state,
      Empty(),
    );
  });

  group('World Time Event', () {
    final tWorldTime = WorldTime(
        timezone: "Accra/Ghana", datetime: "2022-12-10T18:25:15.772956+00:00");
    final tTimezone = "Accra/Ghana";
    test('get data from getTime usecase', () async {
      //Arrange
      when(mockGetWorldTime(any)).thenAnswer((_) async => Right(tWorldTime));
      //Act
      bloc.add(GetTime(tTimezone));
      await untilCalled(mockGetWorldTime(any));
      //Assert
      verify(mockGetWorldTime(Params(timezone: tTimezone)));
    });

    test('should emit [Loading],[Loaded] when data is gotten sucessfully',
        () async {
      //Arrange
      when(mockGetWorldTime(any)).thenAnswer((_) async => Right(tWorldTime));
      //Act
      final expected = [Empty(), Loading(), Loaded(worldTime: tWorldTime)];
 
      //Assert
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.add(GetTime(tTimezone));
    });

     test('should emit [Loading],[Error] when data getting fails ',
        () async {
      //Arrange
      when(mockGetWorldTime(any)).thenAnswer((_) async => Left(Failures()));
      //Act
      final expected = [Empty(), Loading(), Error(message: "Server Failure")];
 
      //Assert
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.add(GetTime(tTimezone));
    });
  });
}
