import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DesisionListEvent extends Equatable {
  DesisionListEvent([List props = const []]) : super(props);
}

class InitDesisionListEvent extends DesisionListEvent {}

class DeleteDesisionEvent extends DesisionListEvent {}
