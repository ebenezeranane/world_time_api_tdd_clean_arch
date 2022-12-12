import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

///create a base [UseCase] class for all usecases
abstract class UseCase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}



///call the [NoParams] class when there are no parameters to callable
class NoParams extends Equatable {

  @override
  List<Object> get props => [];
}