import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RouletteOption extends Equatable {
  String title;
  String rouletteId;
  Color color;

  RouletteOption(this.title, this.rouletteId, this.color)
      : super([title, rouletteId, color]);
}
