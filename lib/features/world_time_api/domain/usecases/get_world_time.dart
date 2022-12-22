import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:world_time_api_tdd_clean_arch/core/usecases/usecase.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/repositories/get_world_time_repository.dart';

import '../../../../core/errors/failures.dart';

class GetWorldTime implements UseCase<WorldTime,Params> {
  final GetWorldTimeRepository repository;

  GetWorldTime(this.repository);

  @override
  Future<Either<Failures, WorldTime>> call(Params params) async {
    return await repository.getTime(params.timezone);
  }
}

class Params extends Equatable {
  final String timezone;
  const Params({this.timezone}) ;
  
  @override
  // TODO: implement props
  List<Object> get props => [timezone];
}
