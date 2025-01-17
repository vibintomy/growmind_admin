import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class WavyPath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red // Customize color as needed
      ..style = PaintingStyle.fill;

    final path = Path();

    // Define wave parameters (adjust as desired)
    double amplitude = 20.0;
    double frequency = 0.5;

    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x += 10) {
      double y = size.height / 2 + amplitude * sin(x * frequency);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}