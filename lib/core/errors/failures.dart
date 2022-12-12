import 'package:equatable/equatable.dart';

class Failures extends Equatable {
  Failures([List props = const <dynamic>[]]) : super(props);
}


class ServerFailure extends Failures{}

class CacheFailure extends Failures{}