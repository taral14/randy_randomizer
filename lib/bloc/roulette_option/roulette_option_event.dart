import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RouletteOptionEvent extends Equatable {
  RouletteOptionEvent([List props = const []]) : super(props);
}
