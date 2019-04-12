import 'package:equatable/equatable.dart';

class Roulette extends Equatable {
  String title;
  String id;

  Roulette(this.id, this.title) : super([id, title]);
}
