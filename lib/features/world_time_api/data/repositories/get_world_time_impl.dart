import 'package:world_time_api_tdd_clean_arch/core/errors/exceptions.dart';
import 'package:world_time_api_tdd_clean_arch/core/network/network_info.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/datasources/local_data_source.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/datasources/remote_data_source.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';
import 'package:dartz/dartz.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/repositories/get_world_time_repository.dart';

import '../../../../core/errors/failures.dart';



class GetWorldTimeRepositoryImpl implements GetWorldTimeRepository {
  final WorldTimeRemoteDataSource worldTimeRemoteDataSource;
  final WorldTimeLocalDataSource worldTimeLocalDataSource;
  final NetworkInfo networkInfo;

  GetWorldTimeRepositoryImpl(
      {this.worldTimeRemoteDataSource,
      this.worldTimeLocalDataSource,
      this.networkInfo});

  @override
  Future<Either<Failures, WorldTime>> getTime(String timezone) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTime = await worldTimeRemoteDataSource.getTime(timezone);

        worldTimeLocalDataSource.cacheTime(remoteTime);

        return Right(remoteTime);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTime = await worldTimeLocalDataSource.getLastTime();

        return Right(localTime);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
