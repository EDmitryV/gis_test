import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'planet.g.dart';

@HiveType(typeId: 1)
class Planet {
  @HiveField(0)
  final double radius;
  @HiveField(1)
  final Color color;
  @HiveField(2)
  final double remoteness;
  @HiveField(3)
  final double speed;

  Planet(
      {required this.color,
      required this.remoteness,
      required this.speed,
      required this.radius});
}
