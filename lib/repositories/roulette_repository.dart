import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/providers/db_provider.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart';

class RouletteRepository {
  final Future<Database> _database = DbProvider.instance.db;
  final String table = 'Desisions';

  Future<Roulette> getFirst() async {
    var db = await _database;
    final maps = await db.query(table, limit: 1);

    if (maps.length > 0) {
      return Roulette.fromDb(maps[0]);
    }
    return Roulette(0, '');
  }

  Future<List<Roulette>> findAll() async {
    var db = await _database;
    final maps = await db.query(table);

    if (maps.length == 0) {
      return [];
    }
    return maps.map((data) => Roulette.fromDb(data)).toList();
  }

  Future<int> deleteById(int id) async {
    final db = await _database;
    return db.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> insert(Roulette roulette) async {
    final db = await _database;
    return db.insert(
      table,
      roulette.toMap(),
    );
  }

  Future<bool> save(Roulette roulette) async {
    final db = await _database;
    if (roulette.id == null) {
      int id = await insert(roulette);
      roulette.id = id;
    } else {
      await db.update(
        table,
        roulette.toMap(),
        where: "id = ?",
        whereArgs: [roulette.id],
      );
    }
    return true;
  }
}
