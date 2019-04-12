import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';

@immutable
abstract class CurrentEvent extends Equatable {
  CurrentEvent([List props = const []]) : super(props);
}

class InitCurrentEvent extends CurrentEvent {}

class ChangeCurrentEvent extends CurrentEvent {
  final Roulette roulette;

  ChangeCurrentEvent(this.roulette);
}
