import 'package:flutter/material.dart';

class UnderlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white // Color of the underline
      ..strokeWidth = 2 // Thickness of the underline
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.moveTo(0, size.height / 2); // Start point of the underline
    path.lineTo(size.width, size.height / 2); // End point of the underline

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}