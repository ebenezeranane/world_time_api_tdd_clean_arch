import 'package:equatable/equatable.dart';

class WorldTime extends Equatable {
  
  final String timezone;
  final String datetime;

  WorldTime({this.timezone,this.datetime})
      : super([ timezone,datetime]);
}
