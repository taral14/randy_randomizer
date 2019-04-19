import 'package:randy_randomizer/models/roulette.dart';
import 'dart:async';

class RouletteRepository {
  Future<Roulette> getFirst() async {
    await Future.delayed(Duration(milliseconds: 100));
    return Roulette(1, 'Что скушать сегодня утром?');
  }

  Future<List<Roulette>> findAll() async {
    await Future.delayed(Duration(milliseconds: 100));
    return [
      Roulette(1, 'Что скушать сегодня утром?'),
      Roulette(2, 'Куда сходить вечером?'),
      Roulette(3, 'Кому позвонить?'),
    ];
  }

  Future<int> save(Roulette roulette) async {
    return 1;
  }
}
