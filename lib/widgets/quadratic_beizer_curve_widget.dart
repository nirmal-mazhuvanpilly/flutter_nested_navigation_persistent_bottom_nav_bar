// import 'dart:ui' as grad;
import 'package:flutter/material.dart';

class QuadraticBeizerCurveWidget extends StatelessWidget {
  const QuadraticBeizerCurveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Opacity(
          opacity: .50,
          child: Align(
            alignment: const Alignment(0.0, 0.90),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: CustomPaint(
                painter: MyPainter(color: Colors.green.shade700),
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment(0.0, 1.0),
          child: SizedBox(
            height: 500,
            width: double.infinity,
            child: CustomPaint(
              painter: MyPainter(color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final Color color;
  const MyPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      // ..shader = grad.Gradient.linear(
      //   Offset(0, size.height),
      //   Offset(size.width, size.height),
      //   [
      //     Colors.green,
      //     Colors.green.shade800,
      //   ],
      // )
      ..shader = LinearGradient(colors: [
        Colors.green.shade800,
        Colors.green,
        Colors.green.shade800
      ]).createShader(
          Rect.fromCircle(center: Offset(size.width / 2, 0), radius: 500))
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.moveTo(0, size.height * .90);
    path.quadraticBezierTo(size.width * .20, size.height * .85,
        size.width * .50, size.height * .95);
    path.quadraticBezierTo(
        size.width * .70, size.height * 1, size.width, size.height * .90);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
