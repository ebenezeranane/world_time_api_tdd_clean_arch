import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:world_time_api_tdd_clean_arch/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MockDataConnectionChecker mockDataConnectionChecker;
  NetworkInfo networkInfo;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('Isconnected', () {
    test('forward the call to DataConnectionChecker.hasConnection', () async {
      //Arrange
      final tHasConnectionFuture = Future.value(true);
      when(networkInfo.isConnected).thenAnswer((_) => tHasConnectionFuture);

      //Act
      Future<bool> result;
       result = networkInfo.isConnected;

      expect(result, tHasConnectionFuture);
      //Assert
      verify(mockDataConnectionChecker.hasConnection);
    });
  });
}
