import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_time_api_tdd_clean_arch/core/network/network_info.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/datasources/local_data_source.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/datasources/remote_data_source.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/repositories/get_world_time_impl.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/repositories/get_world_time_repository.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/usecases/get_world_time.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/presentation/bloc/world_time_api_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {

  //Features
  //Bloc
  sl.registerFactory(() => WorldTimeApiBloc(getWorldTime: sl()));

  //usecases
  sl.registerLazySingleton(() => GetWorldTime(sl()));

  sl.registerLazySingleton<GetWorldTimeRepository>(() =>
      GetWorldTimeRepositoryImpl(
          worldTimeRemoteDataSource: sl(),
          worldTimeLocalDataSource: sl(),
          networkInfo: sl()));

  //Data Sources
  sl.registerLazySingleton<WorldTimeRemoteDataSource>(
      () => WorldRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<WorldTimeLocalDataSource>(
      () => WorldTimeLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreference = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreference);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
