import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gis_test/animation/painter.dart';
import 'package:gis_test/consts.dart';
import 'package:gis_test/models/planet.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  Box<Planet> planetsBox = Hive.box(planetsBoxName);
  late AnimationController _animationController;
  @override
  void initState() {
    if (planetsBox.length == 0) {
      planetsBox.add(
          Planet(color: Colors.yellow, remoteness: 0, speed: 0, radius: 50));
    }
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 5), upperBound: 2 * pi);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Planetarium"),
      ),
      body: InteractiveViewer(
        child: CustomPaint(
          painter: Painter(_animationController),
          child: Container(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_planet').then((planet) {
            if (planet != null) {
              setState(() {
                planetsBox.add(planet as Planet);
              });
            }
          });
        },
        tooltip: 'Add planet',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    planetsBox.close();
    super.dispose();
  }
}
