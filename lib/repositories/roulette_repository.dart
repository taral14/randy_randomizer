import 'package:randy_randomizer/models/roulette.dart';
import 'dart:async';

class RouletteRepository {
  Future<Roulette> getFirst() async {
    await Future.delayed(Duration(milliseconds: 100));
    return Roulette('Roulette_1', 'Что скушать сегодня утром?');
  }
}
