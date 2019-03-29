import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'dart:async';
import 'package:flutter/material.dart';

const BLUE_NORMAL = Color(0xff54c5f8);
const GREEN_NORMAL = Color(0xff6bde54);
const BLUE_DARK2 = Color(0xff01579b);
const BLUE_DARK1 = Color(0xff29b6f6);
const RED_DARK1 = Color(0xfff26388);
const RED_DARK2 = Color(0xfff782a0);
const RED_DARK3 = Color(0xfffb8ba8);
const RED_DARK4 = Color(0xfffb89a6);
const RED_DARK5 = Color(0xfffd86a5);
const YELLOW_NORMAL = Color(0xfffcce89);

class RouletteOptionRepository {
  Future<List<RouletteOption>> getAllOptions() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      RouletteOption('Конфетки', 'Roulette_1', RED_DARK1),
      RouletteOption('Большая булочка с сосиской', 'Roulette_1', BLUE_NORMAL),
      RouletteOption('Сардельки', 'Roulette_1', GREEN_NORMAL),
      RouletteOption('Яблоко', 'Roulette_1', RED_DARK5),
      RouletteOption('Банан', 'Roulette_1', YELLOW_NORMAL),
      RouletteOption('Арбуз', 'Roulette_1', RED_DARK1),
      RouletteOption('Творог', 'Roulette_1', BLUE_NORMAL),
      RouletteOption('Баклажан', 'Roulette_1', GREEN_NORMAL),
      RouletteOption('Картошка', 'Roulette_1', RED_DARK5),
    ];
  }

  Future<List<RouletteOption>> getRouletteOptions(Roulette roulette) async {
    var list = await getAllOptions();
    return list
        .where((RouletteOption op) => op.rouletteId == roulette.id)
        .toList();
  }
}
