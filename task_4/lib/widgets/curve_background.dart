import 'package:flutter/material.dart';

class CurvePainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    // TODO: Set properties to paint
    paint.color = Color(0xFFE5B5E5);
    paint.style = PaintingStyle.fill;

    // Path or curve descriptions
    var path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.82,
        size.width * 0.5, size.height * 0.81);
    path.quadraticBezierTo(
        size.width * 0.7, size.height * 0.8, size.width, size.height * 0.85);
    path.lineTo(size.width, 0);

    // TODO: Draw your path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CurvePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Gradient Colors
    var colors = [Color(0xFFDEC2FC), Color(0xFF90C5FC)];
    var stops = [0.25, 1.0];
    var gradient = LinearGradient(
        colors: colors,
        stops: stops,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);
    var bounds = Rect.fromLTWH(0, 0, size.width, size.height * 0.8);

    var paint = Paint()..shader = gradient.createShader(bounds);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.lineTo(0, size.height * 0.85);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.87,
        size.width * 0.5, size.height * 0.79);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.75, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    // path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
