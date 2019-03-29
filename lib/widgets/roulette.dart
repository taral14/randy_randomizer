import 'package:flutter/material.dart';
import '../models/roulette_option.dart';
import 'dart:math';

class Roulette extends StatelessWidget {
  final List<RouletteOption> options;

  Roulette({@required this.options});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(800, 800),
      painter: RoulettePainter(
        options: options,
      ),
      child: Container(),
    );
  }
}

class RoulettePainter extends CustomPainter {
  RoulettePainter({this.options});

  final List<RouletteOption> options;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    double radius = size.width / 2 - 10;
    Rect rect = Rect.fromCircle(center: Offset(0, 0), radius: radius);
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;

    paint.color = Colors.grey[200];
    canvas.drawCircle(Offset(0, 0), size.width / 2, paint);

    for (int i = 0; i < options.length; i++) {
      RouletteOption option = options[i];
      double radians = 2 * pi / options.length;
      var textPainter = getTextPainter(option.title);
      paint.color = option.color;
      canvas.drawArc(rect, 0, radians, true, paint);
      canvas.rotate(radians / 2);
      textPainter.layout(maxWidth: size.width / 2 - 65);
      textPainter.paint(canvas, Offset(50, -5));
      canvas.rotate(radians / 2);
    }

    paint.color = Colors.grey[200];
    canvas.drawCircle(Offset(0, 0), 35, paint);

    canvas.save();
    canvas.restore();
  }

  TextPainter getTextPainter(String text) {
    final TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 14.0,
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
