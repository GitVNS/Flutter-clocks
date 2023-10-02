import 'dart:math';

import 'package:flutter/material.dart';

class Clock2 extends StatefulWidget {
  const Clock2({super.key});

  @override
  State<Clock2> createState() => _Clock2State();
}

class _Clock2State extends State<Clock2> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late Animation<int> seconds;
  late Animation<int> minutes;
  late Animation<int> hours;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60))
          ..repeat();
    _animationController1 = AnimationController(
        vsync: this, duration: const Duration(seconds: 3600))
      ..repeat();
    _animationController2 = AnimationController(
        vsync: this, duration: const Duration(seconds: 108000))
      ..repeat();
    seconds = IntTween(begin: 0, end: 360).animate(_animationController);
    minutes = IntTween(begin: 0, end: 360).animate(_animationController1);
    hours = IntTween(begin: 0, end: 360).animate(_animationController2);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController1.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white10,
          ),
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: Clock2Painter(seconds: seconds.value),
              ),
            );
          },
        ),
      ],
    );
  }
}

class Clock2Painter extends CustomPainter {
  final int seconds;
  Clock2Painter({required this.seconds});

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);

    Paint secondsPaint = Paint()..color = Colors.lime;

    var hx = center.dx + (size.width / 2) * cos((270 + seconds) * pi / 180);
    var hy = center.dy + (size.width / 2) * sin((270 + seconds) * pi / 180);
    canvas.drawCircle(Offset(hx, hy), size.width * 0.045, secondsPaint);
    canvas.drawCircle(
        center,
        size.width / 2,
        secondsPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.015);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
