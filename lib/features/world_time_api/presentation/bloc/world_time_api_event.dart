part of 'world_time_api_bloc.dart';

abstract class WorldTimeApiEvent extends Equatable {
  WorldTimeApiEvent();

  @override
  List<Object> get props => [];
}

class getTime extends WorldTimeApiEvent {
  final timezone;

  getTime(this.timezone);
}
