import 'package:flutter/material.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/presentation/pages/world_time_home.dart';
import 'package:world_time_api_tdd_clean_arch/features/world_time_api/presentation/pages/world_time_places.dart';
import 'package:world_time_api_tdd_clean_arch/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: WorldTimeHome(),
    );
  }
}
