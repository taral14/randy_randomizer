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

const BLUE_NORMAL = Color(0xff54c5f8);
const GREEN_NORMAL = Color(0xff6bde54);
const BLUE_DARK2 = Color(0xff01579b);
const BLUE_DARK1 = Color(0xff29b6f6);
const RED_DARK1 = Color(0xfff26388);
const RED_DARK2 = Color(0xfff782a0);
const RED_DARK3 = Color(0xfffb8ba8);
const RED_DARK4 = Color(0xfffb89a6);
const RED_DARK5 = Color(0xfffd86a5);
const YELLOW_NORMAL = Color(0xfffcce89);

const COLORS = [RED_DARK1, BLUE_NORMAL, GREEN_NORMAL, RED_DARK5, YELLOW_NORMAL];

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
      paint.color = COLORS[i % COLORS.length];
      canvas.drawArc(rect, 0, radians, true, paint);
      canvas.rotate(radians / 2);
      drawText(canvas, size.width / 2 - 57, option.title);
      canvas.rotate(radians / 2);
    }

    paint.color = Colors.grey[200];
    canvas.drawCircle(Offset(0, 0), 35, paint);

    canvas.save();
    canvas.restore();
  }

  void drawText(Canvas canvas, double maxWidth, String text) {
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

    textPainter.layout(maxWidth: maxWidth);
    textPainter.paint(canvas, Offset(50, -5));
  }

  @override
  bool shouldRepaint(RoulettePainter oldDelegate) => true;
}
