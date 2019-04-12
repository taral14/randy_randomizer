import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final VoidCallback onPressed;

  final String imagePath;
  final double size;

  AppBarButton({this.onPressed, this.imagePath, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.transparent,
        child: Image.asset(imagePath, width: size, height: size),
      ),
    );
  }
}
