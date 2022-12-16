part of 'world_time_api_bloc.dart';

abstract class WorldTimeApiState extends Equatable {
  WorldTimeApiState();

  @override
  List<Object> get props => [];
}

//when the app has no data or in its initial empty state
class Empty extends WorldTimeApiState {}

// when data is being fecthed from the api
class Loading extends WorldTimeApiState {}

// when the data has been fetched and loaded
class Loaded extends WorldTimeApiState {
  final WorldTime worldTime;

  Loaded({this.worldTime});
}

// when there is an exception and an error message needs to be displayed
class Error extends WorldTimeApiState {
  final String message;

  Error({this.message});
}
