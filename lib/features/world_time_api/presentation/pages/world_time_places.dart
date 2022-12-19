import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/domain/entities/world_time.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/presentation/bloc/world_time_api_bloc.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/presentation/pages/world_time_home.dart';

import '../../../../injection_container.dart';

class WorldTimePlaces extends StatelessWidget {
  List<WorldTime> locations = [
    WorldTime(timezone: 'Africa/Accra', location: 'Ghana', flag: 'ghana.gif'),
    WorldTime(
        timezone: 'Europe/Berlin', location: 'Germany', flag: 'germany.gif'),
    WorldTime(
        timezone: 'Europe/Amsterdam',
        location: 'Netherlands',
        flag: 'nertherlands.gif'),
    WorldTime(timezone: 'Europe/Paris', location: 'France', flag: 'france.gif'),
    WorldTime(timezone: 'Europe/Rome', location: 'Italy', flag: 'italy.gif'),
    WorldTime(
        timezone: 'Europe/Prague',
        location: 'Czech Republic',
        flag: 'czech.gif'),
    WorldTime(
        timezone: 'Europe/Zurich',
        location: 'Switzerland',
        flag: 'switzerland.gif'),
    WorldTime(
        timezone: 'Europe/Lisbon', location: 'Portugal', flag: 'portugal.gif'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: const Text('Choose Location'),
          elevation: 0,
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    BlocProvider.of<WorldTimeApiBloc>(context)
                        .add(GetTime( locations[index].timezone));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const WorldTimeHome())));
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('images/${locations[index].flag}'),
                  ),
                ),
              );
            }));
  }

  void updateTime(index, context) {
    BlocProvider.of<WorldTimeApiBloc>(context)
        .add(GetTime(locations[index].timezone));
  }
}
