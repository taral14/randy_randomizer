import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'dart:async';
import 'package:flutter/material.dart';

const colors = [
  [
    Color.fromRGBO(255, 154, 68, 1),
    Color.fromRGBO(255, 151, 103, 1),
  ],
  [
    Color.fromRGBO(255, 79, 79, 1),
    Color.fromRGBO(238, 121, 121, 1),
  ],
  [
    Color.fromRGBO(68, 119, 255, 1),
    Color.fromRGBO(103, 108, 255, 1),
  ],
  [
    Color.fromRGBO(90, 238, 102, 1),
    Color.fromRGBO(99, 229, 170, 1),
  ],
  [
    Color.fromRGBO(68, 241, 255, 1),
    Color.fromRGBO(103, 156, 255, 1),
  ],
  [
    Color.fromRGBO(4, 124, 255, 1),
    Color.fromRGBO(4, 124, 255, 1),
  ],
  [
    Color.fromRGBO(151, 68, 255, 1),
    Color.fromRGBO(103, 105, 255, 1),
  ],
  [
    Color.fromRGBO(255, 219, 68, 1),
    Color.fromRGBO(255, 180, 103, 1),
  ],
];

class RouletteOptionRepository {
  Future<List<RouletteOption>> getAllOptions() async {
    await Future.delayed(Duration(milliseconds: 100));
    return [
      RouletteOption('Конфетки', 'Roulette_1', colors[0]),
      RouletteOption('Большая булочка с сосиской', 'Roulette_1', colors[1]),
      RouletteOption('Сардельки', 'Roulette_1', colors[2]),
      RouletteOption('Яблоко', 'Roulette_1', colors[3]),
      RouletteOption('Банан', 'Roulette_1', colors[4]),
      RouletteOption('Арбуз', 'Roulette_1', colors[5]),
      RouletteOption('Творог', 'Roulette_1', colors[6]),
      RouletteOption('Баклажан', 'Roulette_1', colors[7]),
      //RouletteOption('Картошка', 'Roulette_1', colors[6]),
    ];
  }

  Future<List<RouletteOption>> getRouletteOptions(Roulette roulette) async {
    var list = await getAllOptions();
    return list
        .where((RouletteOption op) => op.rouletteId == roulette.id)
        .toList();
  }
}
