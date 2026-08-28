import 'package:flutter/material.dart';

class PointyBottomPainter extends CustomPainter {
  final Color color;

  const PointyBottomPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      // Pointy tip at bottom
      ..moveTo(size.width / 2, size.height)
      ..lineTo(size.width * 0.08, size.height * 0.35)
      ..quadraticBezierTo(
        size.width * 0.02,
        size.height * 0.15,
        size.width / 2,
        size.height * 0.05,
      )
      ..quadraticBezierTo(
        size.width * 0.98,
        size.height * 0.15,
        size.width * 0.92,
        size.height * 0.35,
      )
      ..close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // White border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, borderPaint);

    // Inner white circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.28),
      6,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}