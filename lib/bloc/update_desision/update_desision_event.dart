import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/models/roulette_option.dart';

@immutable
abstract class UpdateDesisionEvent extends Equatable {
  UpdateDesisionEvent([List props = const []]) : super(props);
}

class InitUpdateDesisionEvent extends UpdateDesisionEvent {
  final Roulette roulette;

  InitUpdateDesisionEvent(this.roulette) : super([roulette]);
}

class UpdateTitleEvent extends UpdateDesisionEvent {
  final String title;

  UpdateTitleEvent(this.title) : super([title]);
}

class RemoveOptionEvent extends UpdateDesisionEvent {
  final RouletteOption option;

  RemoveOptionEvent(this.option) : super([option]);
}

class AddOptionEvent extends UpdateDesisionEvent {}
