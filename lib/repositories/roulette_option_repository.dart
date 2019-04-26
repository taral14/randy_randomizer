import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'dart:async';
import 'package:randy_randomizer/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class RouletteOptionRepository {
  final Future<Database> _database = DbProvider.instance.db;
  final String table = 'Options';

  Future<List<RouletteOption>> getRouletteOptions(Roulette roulette) async {
    final db = await _database;
    final maps = await db
        .query(table, where: "rouletteId = ?", whereArgs: [roulette.id]);
    if (maps.length == 0) {
      return [];
    }
    return maps.map((data) => RouletteOption.fromDb(data)).toList();
  }

  Future<int> addOptionToRoulette(
      Roulette roulette, RouletteOption option) async {
    option.rouletteId = roulette.id;
    return save(option);
  }

  Future<int> deleteById(int optionId) async {
    final db = await _database;
    return db.delete(
      table,
      where: "id = ?",
      whereArgs: [optionId],
    );
  }

  Future<int> save(RouletteOption option) async {
    final db = await _database;
    if (option.id == null) {
      return db.insert(
        table,
        option.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } else {
      return db.update(
        table,
        option.toMap(),
        where: "id = ?",
        whereArgs: [option.id],
      );
    }
  }
}
