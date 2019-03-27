import 'package:flutter/material.dart';

class RouletteTitle extends StatelessWidget {
  final String title;

  const RouletteTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = 24.0;
    if (title.length > 30) {
      fontSize = 14.0;
    } else if (title.length > 20) {
      fontSize = 18.0;
    }

    return Container(
      alignment: Alignment.center,
      height: 40.0,
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
