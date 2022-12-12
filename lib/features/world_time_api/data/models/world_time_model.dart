import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';

class WorldTimeModel extends WorldTime {
  WorldTimeModel({String datetime, String timezone})
      : super(timezone: timezone, datetime: datetime);

  factory WorldTimeModel.fromJson(Map<String, dynamic> jsonData) {
    return WorldTimeModel(
        datetime: jsonData['datetime'], timezone: jsonData['timezone']);
  }

  Map<String, dynamic> toJson() {
    return {
      "datetime": datetime,
      "timezone": timezone
     };
  }
}
