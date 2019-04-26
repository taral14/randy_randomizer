import 'package:equatable/equatable.dart';

class Roulette extends Equatable {
  String title;
  int id;

  Roulette(this.id, this.title) : super([id, title]);

  static Roulette fromDb(Map<String, dynamic> data) {
    return Roulette(data['id'], data['title']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "title": title,
    };
  }
}
