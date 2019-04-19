import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class OptionDbProvider {
  Database db;

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "options-12.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database newDb, int version) {
    print('Create table Options');
    newDb
      ..execute(
          "CREATE TABLE Options (id INTEGER PRIMARY KEY, title TEXT, rouletteId INTEGER)")
      ..insert('Options', {"title": "Банан", "rouletteId": 1})
      ..insert('Options', {"title": "Арбуз", "rouletteId": 1})
      ..insert('Options', {"title": "Сардельки", "rouletteId": 1});
  }

  Future<RouletteOption> fetchItem(int id) async {
    final maps = await db.query("Options", where: "id = ?", whereArgs: [id]);
    if (maps.length > 0) {
      return RouletteOption.fromDb(maps.first);
    }

    return null;
  }

  Future<List<RouletteOption>> fetchAllByRoulette(int rouletteId) async {
    final maps = await db
        .query("Options", where: "rouletteId = ?", whereArgs: [rouletteId]);

    if (maps.length == 0) {
      return [];
    }
    return maps.map((data) => RouletteOption.fromDb(data)).toList();
  }

  Future<int> insert(RouletteOption option) {
    return db.insert(
      "Options",
      option.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> deleteOne(int id) {
    return db.delete(
      'Options',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteByRoulette(int rouletteId) {
    return db.delete(
      'Options',
      where: "rouletteId = ?",
      whereArgs: [rouletteId],
    );
  }

  Future<int> update(int id, RouletteOption option) {
    return db.update(
      "Options",
      option.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> clear() {
    return db.delete("Options");
  }
}

var optionDbProvider = OptionDbProvider();
