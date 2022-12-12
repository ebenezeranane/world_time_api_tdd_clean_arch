import 'package:dartz/dartz.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/repositories/get_world_time_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/usecases/get_world_time.dart';

class MockGetWorldTimeRepository extends Mock
    implements GetWorldTimeRepository {}

void main() {
  GetWorldTime usecase;
  MockGetWorldTimeRepository mockGetWorldTimeRepository;

  // initialize test
  setUp(() {
    mockGetWorldTimeRepository = MockGetWorldTimeRepository();
    usecase = GetWorldTime(repository: mockGetWorldTimeRepository);
  });

  // test parameters
  final tTimezone = "Africa/Accra";
  

  final tWorldtime =
      WorldTime( timezone: "Africa/Accra",datetime: "2022-12-10T18:25:15.772956+00:00");

  test('should get time data from repository', () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    // When getTime is called with no argument, always answer with
    // the Right "side" of Either containing a test tWorldTime object.
    when(mockGetWorldTimeRepository.getTime(tTimezone))
        .thenAnswer((_) async => Right(tWorldtime));

    // the act phase of the test. call the yet not existent method of the usecase
    final result = await usecase(Params(timezone:tTimezone));

    // usecase should simply return whatever was returned from the repository
    expect(result, Right(tWorldtime));

    // verify that the method has been called on the repository
    // this also verifies that the arg for the usecase is still the same for the mthod
    // on the repository because usecase get its data from the repository
    verify(mockGetWorldTimeRepository.getTime(tTimezone));

    // only the above should be called and nothing more
    verifyNoMoreInteractions(mockGetWorldTimeRepository);
  });
}
