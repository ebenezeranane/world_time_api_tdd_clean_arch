part of 'world_time_api_bloc.dart';

abstract class WorldTimeApiEvent extends Equatable {
  const WorldTimeApiEvent();

  @override
  List<Object> get props => [];
}

class GetTime extends WorldTimeApiEvent {
  final timezone;

  const GetTime(this.timezone);

   @override
  List<Object> get props => [timezone];
}
