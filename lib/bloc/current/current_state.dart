import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';

@immutable
abstract class CurrentState extends Equatable {
  CurrentState([List props = const []]) : super(props);
}

class InitialCurrentState extends CurrentState {}

class LoadedCurrentState extends CurrentState {
  final Roulette roulette;

  LoadedCurrentState(this.roulette) : super([roulette]);
}
