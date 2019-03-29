import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/models/roulette_option.dart';

@immutable
abstract class RouletteState extends Equatable {
  RouletteState([List props = const []]) : super(props);
}

class InitialRouletteState extends RouletteState {}

class LoadedRouletteState extends RouletteState {
  final Roulette roulette;
  final List<RouletteOption> options;

  LoadedRouletteState({this.roulette, this.options})
      : super([roulette, options]);
}
