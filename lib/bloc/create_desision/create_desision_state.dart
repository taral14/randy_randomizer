import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/models/roulette_option.dart';

@immutable
abstract class CreateDesisionState extends Equatable {
  CreateDesisionState([List props = const []]) : super(props);
}

class LoadingCreateDesisionState extends CreateDesisionState {}

class SuccessSavedDesisionState extends CreateDesisionState {}

class LoadedCreateDesisionState extends CreateDesisionState {
  final Roulette roulette;

  final List<RouletteOption> options;

  LoadedCreateDesisionState(this.roulette, this.options)
      : super([roulette, options]);
}
