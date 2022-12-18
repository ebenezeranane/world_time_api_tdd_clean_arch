import 'package:equatable/equatable.dart';

class Failures extends Equatable {
  
  Failures([List props = const <dynamic>[]]);
  
  @override
  // TODO: implement props
  List<Object> get props => [props];
}


class ServerFailure extends Failures{}

class CacheFailure extends Failures{}