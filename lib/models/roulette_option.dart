import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RouletteOption extends Equatable {
  String title;
  String rouletteId;
  List<Color> colors;

  RouletteOption(this.title, this.rouletteId, this.colors)
      : super([title, rouletteId, colors]);

  RadialGradient get gradient {
    return RadialGradient(
      colors: colors,
      stops: [0.0, 1.0],
    );
  }
}
