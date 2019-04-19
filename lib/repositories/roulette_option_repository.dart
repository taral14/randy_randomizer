import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'dart:async';
import 'package:randy_randomizer/providers/OptionDbProvider.dart';

class RouletteOptionRepository {
  Future<List<RouletteOption>> getRouletteOptions(Roulette roulette) async {
    return optionDbProvider.fetchAllByRoulette(roulette.id);
  }

  Future<int> addOptionToRoulette(
      Roulette roulette, RouletteOption option) async {
    option.rouletteId = roulette.id;
    return save(option);
  }

  Future<int> deleteById(int optionId) async {
    return optionDbProvider.deleteOne(optionId);
  }

  Future<int> save(RouletteOption option) async {
    if (option.id == null) {
      return optionDbProvider.insert(option);
    } else {
      return optionDbProvider.update(option.id, option);
    }
  }
}
