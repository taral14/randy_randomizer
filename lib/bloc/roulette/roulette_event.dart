import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RouletteEvent extends Equatable {
  RouletteEvent([List props = const []]) : super(props);
}
