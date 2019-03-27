import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RouletteOptionState extends Equatable {
  RouletteOptionState([List props = const []]) : super(props);
}

class InitialRouletteOptionState extends RouletteOptionState {}
