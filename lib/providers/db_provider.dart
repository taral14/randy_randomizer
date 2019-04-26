import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class DbProvider {
  final int version = 1;

  Database _database;

  DbProvider._constructor();

  static final DbProvider _instance = DbProvider._constructor();

  factory DbProvider() {
    return _instance;
  }

  static DbProvider get instance {
    return _instance;
  }

  Future<Database> get db async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  _initDb() async {
    final path = await _getPath();
    return openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
    );
  }

  Future<String> _getPath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, "randy-randomizer-2.db");
  }

  _onCreate(Database newDb, int version) {
    newDb
      ..execute("CREATE TABLE Desisions (id INTEGER PRIMARY KEY, title TEXT)")
      ..insert('Desisions', {"id": 1, "title": "Что скушать утром?"})
      ..insert('Desisions', {"id": 2, "title": "Куда сходить вечером?"})
      ..insert('Desisions', {"id": 3, "title": "Кому позвонить?"});

    newDb
      ..execute(
          "CREATE TABLE Options (id INTEGER PRIMARY KEY, title TEXT, rouletteId INTEGER)")
      ..insert('Options', {"title": "Банан", "rouletteId": 1})
      ..insert('Options', {"title": "Арбуз", "rouletteId": 1})
      ..insert('Options', {"title": "Сардельки", "rouletteId": 1})
      ..insert('Options', {"title": "Кинотеатр", "rouletteId": 2})
      ..insert('Options', {"title": "Кафе", "rouletteId": 2})
      ..insert('Options', {"title": "Ресторан", "rouletteId": 2})
      ..insert('Options', {"title": "Боулинг клуб", "rouletteId": 2})
      ..insert('Options', {"title": "Маме", "rouletteId": 3})
      ..insert('Options', {"title": "Папе", "rouletteId": 3})
      ..insert('Options', {"title": "Юле", "rouletteId": 3})
      ..insert('Options', {"title": "Пете", "rouletteId": 3});
  }
}
