import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gis_test/consts.dart';
import 'package:gis_test/models/planet.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Painter extends CustomPainter {
  final Animation<double> animation;
  Painter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    Box<Planet> planetsBox = Hive.box(planetsBoxName);
    for (Planet planet in planetsBox.values) {
      canvas.drawCircle(
          Offset(size.width / 2 + planet.remoteness * cos(animation.value), size.height / 2 + planet.remoteness * sin(animation.value)),
          planet.radius,
          Paint()..color = planet.color);
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2),
          planet.remoteness,
          Paint()
            ..color = planet.color.withOpacity(planet.color.opacity * 0.5)
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(Painter oldDelegate) => false;
}
