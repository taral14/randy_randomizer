import 'package:flutter/material.dart';
import 'dart:math';

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

class RandyState extends State<Randy> with TickerProviderStateMixin {
  double scale = 1.0;
  Animation<double> eyeAnimation;
  AnimationController eyeController;

  initState() {
    super.initState();
    eyeController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    eyeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        eyeController.reset();
      }
      eyeController.forward();
    });

    eyeAnimation = Tween<double>(begin: 0.0, end: pi * 2).animate(
      CurvedAnimation(
        parent: eyeController,
        curve: Curves.linear,
      ),
    );

    eyeController.forward();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: onPressStart,
      onTapUp: onPressEnd,
      onTapCancel: onPressCancel,
      child: Container(
        child: buildImage(),
        width: 75.0 * scale,
        height: 90.0 * scale,
      ),
    );
  }

  void onPressCancel() {
    setState(() {
      scale = 1.0;
    });
  }

  void onPressEnd(TapUpDetails details) {
    setState(() {
      scale = 1.0;
    });
  }

  void onPressStart(TapDownDetails details) {
    setState(() {
      scale = 0.90;
    });
  }

  Widget buildImage() {
    switch (widget.status) {
      case RandyStatus.spinning:
        return AnimatedBuilder(
          animation: eyeAnimation,
          builder: (context, child) {
            return randySpinning();
          },
        );
      case RandyStatus.finish:
        return Image.asset('assets/randy_2.png');
      default:
        return Image.asset('assets/randy.png');
    }
  }

  Widget randySpinning() {
    return Stack(
      children: <Widget>[
        Image.asset('assets/randy_4.png'),
        new Positioned(
          child: buildEye(),
          left: 10 * scale,
          top: 26 * scale,
        ),
        new Positioned(
          child: buildEye(),
          right: 10 * scale,
          top: 26 * scale,
        ),
      ],
    );
  }

  Widget buildEye() {
    return Transform.rotate(
      child: Image.asset(
        'assets/randy_4_eye.png',
        width: 17 * scale,
        height: 17 * scale,
      ),
      alignment: Alignment.center,
      angle: eyeAnimation.value,
    );
  }
}
