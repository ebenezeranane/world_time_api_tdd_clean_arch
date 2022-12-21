// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';

import '../../../../core/errors/failures.dart';


abstract class GetWorldTimeRepository{

  Future<Either<Failures,WorldTime>> getTime(String timezone);
}