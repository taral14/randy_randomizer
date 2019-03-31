import 'package:flutter/material.dart';

enum RandyStatus { spinning, init, finish }

class Randy extends StatefulWidget {
  final Function onTap;
  final RandyStatus status;

  Randy({this.onTap, this.status});

  @override
  State<StatefulWidget> createState() {
    return RandyState();
  }
}

class RandyState extends State<Randy> {
  double scale = 1.0;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: onPressStart,
      onTapUp: onPressEnd,
      child: buildImage(),
    );
  }

  void onPressEnd(TapUpDetails details) {
    print('press end');
    setState(() {
      scale = 1.0;
    });
  }

  void onPressStart(TapDownDetails details) {
    print('press start');

    setState(() {
      scale = 1.15;
    });
  }

  Widget buildImage() {
    return Image.asset(
      imagePath,
      width: 90.0 * scale,
      height: 90.0 * scale,
    );
  }

  String get imagePath {
    switch (widget.status) {
      case RandyStatus.spinning:
        return 'assets/randy_4.png';
      case RandyStatus.finish:
        return 'assets/randy_2.png';
      default:
        return 'assets/randy.png';
    }
  }
}
