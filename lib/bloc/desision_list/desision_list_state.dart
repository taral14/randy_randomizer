import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:randy_randomizer/models/roulette.dart';

@immutable
abstract class DesisionListState extends Equatable {
  DesisionListState([List props = const []]) : super(props);
}

class InitialDesisionListState extends DesisionListState {}

class LoadedDesisionListState extends DesisionListState {
  final List<Roulette> items;

  LoadedDesisionListState(this.items);
}
