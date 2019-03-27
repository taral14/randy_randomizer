import 'package:randy_randomizer/models/roulette_option.dart';
import 'dart:async';

class RouletteOptionRepository {
  Future<List<RouletteOption>> getAllOptions() async {
    return [
      RouletteOption('Конфетки', 'Roulette_1'),
      RouletteOption('Большая булочка с сосиской', 'Roulette_1'),
      RouletteOption('Сардельки', 'Roulette_1'),
      RouletteOption('Яблоко', 'Roulette_1'),
      RouletteOption('Банан', 'Roulette_1'),
      RouletteOption('Арбуз', 'Roulette_1'),
      RouletteOption('Творог', 'Roulette_1'),
    ];
  }

  Future<List<RouletteOption>> getRouletteOptions(String rouletteId) async {
    var list = await getAllOptions();
    return list
        .where((RouletteOption op) => op.rouletteId == rouletteId)
        .toList();
  }
}
