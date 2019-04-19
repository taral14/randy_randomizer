import 'package:equatable/equatable.dart';

class RouletteOption extends Equatable {
  int id;
  String title;
  int rouletteId;

  RouletteOption(this.id, this.title, this.rouletteId)
      : super([id, title, rouletteId]);

  static RouletteOption fromDb(Map<String, dynamic> data) {
    return RouletteOption(data['id'], data['title'], data['rouletteId']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "title": title,
      "rouletteId": rouletteId,
    };
  }
}
