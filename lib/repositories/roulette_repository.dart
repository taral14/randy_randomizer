import 'package:randy_randomizer/models/roulette.dart';
import 'dart:async';

class RouletteRepository {
  Future<Roulette> getFirst() async {
    await Future.delayed(Duration(seconds: 1));
    return Roulette('Roulette_1', 'Что скушать сегодня утром?');
  }
}
