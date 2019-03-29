import 'package:equatable/equatable.dart';

class RouletteOption extends Equatable {
  String title;
  String rouletteId;

  RouletteOption(this.title, this.rouletteId) : super([title, rouletteId]);
}
