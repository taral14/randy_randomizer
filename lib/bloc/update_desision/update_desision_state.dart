import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/models/roulette_option.dart';

@immutable
abstract class UpdateDesisionState extends Equatable {
  UpdateDesisionState([List props = const []]) : super(props);
}

class LoadingUpdateDesisionState extends UpdateDesisionState {}

class SuccessSavedDesisionState extends UpdateDesisionState {}

class LoadedUpdateDesisionState extends UpdateDesisionState {
  final Roulette roulette;

  final List<RouletteOption> options;

  LoadedUpdateDesisionState(this.roulette, this.options)
      : super([roulette, options]);
}
