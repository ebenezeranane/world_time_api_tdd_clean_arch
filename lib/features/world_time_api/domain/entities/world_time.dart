import 'package:equatable/equatable.dart';

class WorldTime extends Equatable {
  final String timezone;
  final String datetime;
  final String location;
  final String flag;

  WorldTime({this.timezone, this.datetime,this.flag,this.location}) ;
  
  @override
  // TODO: implement props
  List<Object> get props =>[timezone,datetime,flag,location];
}
