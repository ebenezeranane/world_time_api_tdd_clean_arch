import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_time_api_tdd_clean_arch/core/errors/exceptions.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/models/world_time_model.dart';

class WorldTimeLocalDataSource {
  /// gets the cached [WorldTimeModel] which was gotten last time there
  /// was an internet connection.
  ///
  /// Throws [CacheException] if no cached data found

  Future<WorldTimeModel> getLastTime() {}

  Future<void> cacheTime(WorldTimeModel timetoCache) {}
}

class WorldTimeLocalDataSourceImpl implements WorldTimeLocalDataSource {
  final SharedPreferences sharedPreferences;
  WorldTimeLocalDataSourceImpl({this.sharedPreferences});

  @override
  Future<WorldTimeModel> getLastTime() {
    final jsonString = sharedPreferences.getString('CACHED_TIME');
    if (jsonString != null) {
      return Future.value(WorldTimeModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTime(WorldTimeModel timetoCache) {
    return sharedPreferences.setString(
        "CACHED_TIME", (jsonEncode(timetoCache.toJson())));
  }
}
