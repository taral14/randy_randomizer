import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';

@immutable
abstract class RouletteEvent extends Equatable {
  RouletteEvent([List props = const []]) : super(props);
}

class InitRouletteEvent extends RouletteEvent {}

class ChangeRouletteEvent extends RouletteEvent {
  final Roulette roulette;

  ChangeRouletteEvent(this.roulette);
}
