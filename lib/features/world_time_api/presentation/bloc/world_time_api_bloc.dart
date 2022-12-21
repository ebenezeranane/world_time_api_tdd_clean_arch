// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:world_time_api_tdd_clean_arch/core/errors/failures.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/usecases/get_world_time.dart';

part 'world_time_api_event.dart';
part 'world_time_api_state.dart';

class WorldTimeApiBloc extends Bloc<WorldTimeApiEvent, WorldTimeApiState> {
  final GetWorldTime getWorldTime;

  WorldTimeApiBloc({GetWorldTime getWorldTime})
      // : assert(getWorldTime != null),
      : getWorldTime = getWorldTime,
        super(Empty()) {
    on<WorldTimeApiEvent>((event, emit) async {
      if (event is GetTime) {
        emit(Loading());

        final timezone = event.timezone;
        final failureOrWorldTime =
              await getWorldTime(Params(timezone: timezone));
              failureOrWorldTime.fold(
              (failure) => emit(Error(
                  message: failure is CacheFailure
                      ? "Cache Failure"
                      : "Server Failure")),
              (time) => emit(Loaded(worldTime: time)));

        
      }
    });
  }
}
