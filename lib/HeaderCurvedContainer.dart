import 'package:flutter/material.dart';

class HeaderCurvedContainer extends CustomPainter {
  double point;

  HeaderCurvedContainer({this.point = 150});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()..color = const Color(0xFFdc143c).withOpacity(0.9);
    ;
    Path path = new Path()
      ..relativeLineTo(0, 80.0)
      ..quadraticBezierTo(size.width / 2, point, size.width, 80)
      ..relativeLineTo(0, -80)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
