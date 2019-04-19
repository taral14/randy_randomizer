import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';

@immutable
abstract class RouletteEvent extends Equatable {
  RouletteEvent([List props = const []]) : super(props);
}

class ChangeRouletteEvent extends RouletteEvent {
  final Roulette roulette;

  ChangeRouletteEvent(this.roulette);
}

class ReloadRouletteEvent extends RouletteEvent {}
