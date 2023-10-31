import 'package:flutter/material.dart';
import 'package:gis_test/consts.dart';
import 'package:gis_test/screens/main_screen.dart';
import 'package:gis_test/models/planet.dart';
import 'package:gis_test/screens/new_planet_screen.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(PlanetAdapter());
  await Hive.openBox<Planet>(planetsBoxName);
  runApp(const GisTestApp());
}

class GisTestApp extends StatelessWidget {
  const GisTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planetarium',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/add_planet': (context) => const NewPlanetScreen(),
      },
      home: const MainPage(),
    );
  }
}
