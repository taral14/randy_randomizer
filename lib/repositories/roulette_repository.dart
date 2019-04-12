import 'package:randy_randomizer/models/roulette.dart';
import 'dart:async';

class RouletteRepository {
  Future<Roulette> getFirst() async {
    await Future.delayed(Duration(milliseconds: 100));
    return Roulette('Roulette_1', 'Что скушать сегодня утром?');
  }

  Future<List<Roulette>> findAll() async {
    await Future.delayed(Duration(milliseconds: 100));
    return [
      Roulette('Roulette_1', 'Что скушать сегодня утром?'),
      Roulette('Roulette_2', 'Что посмотреть вечером?'),
      Roulette('Roulette_3', 'Куда сходить погулять?'),
      Roulette('Roulette_4', 'Кому позвонить?'),
    ];
  }
}
