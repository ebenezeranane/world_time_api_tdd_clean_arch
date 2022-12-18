import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/presentation/bloc/world_time_api_bloc.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/presentation/widgets/loader.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/world_time.dart';

class WorldTimeHome extends StatelessWidget {
  const WorldTimeHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String bgImage = 'night.jpg';

    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) {
          (_) => sl<WorldTimeApiBloc>();
        },
        child: BlocBuilder<WorldTimeApiBloc, WorldTimeApiState>(
            bloc: WorldTimeApiBloc(),
            builder: (BuildContext context, state) {
              if (state is Empty) {
                return Container();
              } else if (state is Loading) {
                return const Loader();
              } else if (state is Loaded) {
                return DisplayTime(
                    bgImage: bgImage, displayTime: state.worldTime);
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}

class DisplayTime extends StatelessWidget {
  const DisplayTime({
    Key key,
    @required this.bgImage,
    this.displayTime,
  }) : super(key: key);

  final String bgImage;
  final WorldTime displayTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/$bgImage'), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
        child: Column(
          children: <Widget>[
            TextButton.icon(
              onPressed: () async {},
              icon: const Icon(Icons.edit_location),
              label: const Text('Edit Location'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget>[
                // ignore: prefer_const_constructors
                Text(
                  displayTime.location,
                  style: const TextStyle(
                      fontSize: 25, letterSpacing: 2, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              displayTime.datetime,
              style:
                  const TextStyle(fontSize: 80, letterSpacing: 2, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
