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
    double maxRR = 0.0;
    for (Planet p in planetsBox.values) {
      if (p.radius + p.remoteness > maxRR) {
        maxRR = p.radius + p.remoteness;
      }
    }
    var k = 0.5;
    var padding = 15;
    double ratio;
    if (size.height < size.width) {
      ratio = (size.height - padding) / maxRR * k;
    } else {
      ratio = (size.width - padding) / maxRR * k;
    }
    for (Planet planet in planetsBox.values) {
      canvas.drawCircle(
          Offset(
              size.width / 2 +
                  planet.remoteness *
                      ratio *
                      cos(animation.value * planet.speed),
              size.height / 2 +
                  planet.remoteness *
                      ratio *
                      sin(animation.value * planet.speed)),
          planet.radius * ratio,
          Paint()..color = planet.color);
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2),
          planet.remoteness * ratio,
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
