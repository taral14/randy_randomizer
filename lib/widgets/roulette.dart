import 'package:flutter/material.dart';
import '../models/roulette_option.dart';
import 'dart:math';

const _colors = [
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

class Roulette extends StatefulWidget {
  final List<RouletteOption> options;
  final int selected;

  Roulette({@required this.options, @required this.selected});

  @override
  State<Roulette> createState() {
    return _RouletteState();
  }
}

class _RouletteState extends State<Roulette> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(800, 800),
      painter: RoulettePainter(
        options: widget.options,
        selected: widget.selected,
      ),
      child: Container(),
    );
  }
}

class RoulettePainter extends CustomPainter {
  RoulettePainter({this.options, this.selected});

  final List<RouletteOption> options;
  final int selected;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    Rect rect = Rect.fromCircle(
      center: Offset(0, 0),
      radius: size.width / 2 - 20,
    );
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;

    paint.color = Color.fromRGBO(81, 80, 80, 0.04);
    canvas.drawCircle(Offset(0, 0), size.width / 2, paint);
    paint.color = Colors.grey[350];

    for (int i = 0; i < options.length; i++) {
      RouletteOption option = options[i];
      if (selected == null || selected == i) {
        paint.shader = RadialGradient(
          colors: _colors[i % _colors.length],
        ).createShader(rect);
      } else {
        paint.shader = null;
        paint.color = Colors.grey[350];
      }

      double radians = 2 * pi / options.length;
      var textPainter = makeTextPainter(option.title);
      canvas.drawArc(rect, 0, radians, true, paint);
      canvas.rotate(radians / 2);
      textPainter.layout(maxWidth: size.width / 2 - 65);
      textPainter.paint(canvas, Offset(50, -5));
      canvas.rotate(radians / 2);
    }
    paint.shader = null;

    //paint.color = Colors.grey[200];
    //canvas.drawCircle(Offset(0, 0), 35, paint);

    canvas.save();
    canvas.restore();
  }

  TextPainter makeTextPainter(String text) {
    final TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      height: 0.7,
      fontFamily: 'Roboto',
    );

    TextPainter textPainter = TextPainter(
      text: TextSpan(style: textStyle, text: text),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '...',
      //size: Size(),
    );
    return textPainter;
  }

  @override
  bool shouldRepaint(RoulettePainter oldDelegate) => true;
}
