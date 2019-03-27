import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';

@immutable
abstract class RouletteState extends Equatable {
  RouletteState([List props = const []]) : super(props);
}

class InitialRouletteState extends RouletteState {}

class LoadedRouletteState extends RouletteState {
  final Roulette roulette;

  LoadedRouletteState(this.roulette) : super([roulette]);
}
