import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  BorderPainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.5,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final RRect rrect =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Calculate the total perimeter (approximate for simplicity)
    final double perimeter = 2 * (size.width + size.height);
    final double dashLength = dashWidth + dashSpace;
    final int dashCount = (perimeter / dashLength).floor();

    // Manually draw dashes along the border
    for (int i = 0; i < dashCount; i++) {
      final double distance = i * dashLength;
      _drawDashedSegment(canvas, rrect, paint, distance, dashWidth);
    }
  }

  void _drawDashedSegment(Canvas canvas, RRect rrect, Paint paint,
      double distance, double dashWidth) {
    final Path path = Path();

    // Calculate position along the border
    final double perimeter = 2 * (rrect.width + rrect.height);
    double remainingDistance = distance % perimeter;

    // Top side
    if (remainingDistance < rrect.width) {
      final double x = rrect.left + remainingDistance;
      path.moveTo(x, rrect.top);
      path.lineTo(x + dashWidth, rrect.top);
    }
    // Right side
    else if (remainingDistance < rrect.width + rrect.height) {
      remainingDistance -= rrect.width;
      final double y = rrect.top + remainingDistance;
      path.moveTo(rrect.right, y);
      path.lineTo(rrect.right, y + dashWidth);
    }
    // Bottom side
    else if (remainingDistance < 2 * rrect.width + rrect.height) {
      remainingDistance -= (rrect.width + rrect.height);
      final double x = rrect.right - remainingDistance;
      path.moveTo(x, rrect.bottom);
      path.lineTo(x - dashWidth, rrect.bottom);
    }
    // Left side
    else {
      remainingDistance -= (2 * rrect.width + rrect.height);
      final double y = rrect.bottom - remainingDistance;
      path.moveTo(rrect.left, y);
      path.lineTo(rrect.left, y - dashWidth);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      dashWidth != oldDelegate.dashWidth ||
      dashSpace != oldDelegate.dashSpace ||
      borderRadius != oldDelegate.borderRadius;
}
