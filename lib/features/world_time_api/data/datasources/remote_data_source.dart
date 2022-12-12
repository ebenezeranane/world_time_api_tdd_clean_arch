// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:world_time_api_tdd_clean_arch/core/errors/exceptions.dart';

import 'package:world_time_api_tdd_clean_arch/features/world_time_api/data/models/world_time_model.dart';

import '../../domain/entities/world_time.dart';

class WorldTimeRemoteDataSource {
  ///calls the "https://worldtimeapi.org/api/timezone/" endpoint
  ///returns a [ServerException] for all error codes

  Future<WorldTimeModel> getTime(String timezone) {}
}

class WorldRemoteDataSourceImpl implements WorldTimeRemoteDataSource {
  final http.Client client;

  WorldRemoteDataSourceImpl({
    this.client,
  });

  @override
  Future<WorldTimeModel> getTime(String timezone) async {
    final response = await client.get(
        "https://worldtimeapi.org/api/timezone/$timezone",
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return WorldTimeModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
