import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette_option.dart';

@immutable
abstract class CreateDesisionEvent extends Equatable {
  CreateDesisionEvent([List props = const []]) : super(props);
}

class AddOptionEvent extends CreateDesisionEvent {}

class RemoveOptionEvent extends CreateDesisionEvent {
  final RouletteOption option;

  RemoveOptionEvent(this.option) : super([option]);
}

class SaveFormEvent extends CreateDesisionEvent {}
