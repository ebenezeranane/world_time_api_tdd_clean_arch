// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';

part 'world_time_api_event.dart';
part 'world_time_api_state.dart';

class WorldTimeApiBloc extends Bloc<WorldTimeApiEvent, WorldTimeApiState> {
  WorldTimeApiBloc() : super(Empty()) {
    on<WorldTimeApiEvent>((event, emit) {
      
    });
  }
}
