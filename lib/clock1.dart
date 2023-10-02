import 'dart:math';

import 'package:flutter/material.dart';

class Clock1 extends StatefulWidget {
  const Clock1({super.key});

  @override
  State<Clock1> createState() => _Clock1State();
}

class _Clock1State extends State<Clock1> with TickerProviderStateMixin {
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
                painter: Clock1Painter(
                    seconds: seconds.value,
                    minutes: minutes.value,
                    hours: hours.value),
              ),
            );
          },
        ),
      ],
    );
  }
}

class Clock1Painter extends CustomPainter {
  final int seconds;
  final int minutes;
  final int hours;
  Clock1Painter(
      {required this.seconds, required this.minutes, required this.hours});

  @override
  void paint(Canvas canvas, Size size) {
    Paint secondsPaint = Paint()
      ..color = Colors.lime
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.03;

    var center = Offset(size.width / 2, size.height / 2);
    Rect rect =
        Rect.fromCenter(center: center, width: size.width, height: size.height);
    canvas.drawArc(
        rect, 270 * pi / 180, seconds * pi / 180, false, secondsPaint);
    canvas.drawCircle(center, size.width * 0.05, Paint()..color = Colors.white);

    Paint minutesPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.03;
    var mx = center.dx + (size.width / 3) * cos((270 + minutes) * pi / 180);
    var my = center.dy + (size.width / 3) * sin((270 + minutes) * pi / 180);
    canvas.drawLine(center, Offset(mx, my), minutesPaint);

    Paint hoursPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.02;
    var hx = center.dx + (size.width / 4) * cos((270 + hours) * pi / 180);
    var hy = center.dy + (size.width / 4) * sin((270 + hours) * pi / 180);
    canvas.drawLine(center, Offset(hx, hy), hoursPaint);

    for (int i = 0; i < 4; i++) {
      Paint linesPaint = Paint()
        ..color = Colors.white.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 2;
      var lx = center.dx + (size.width / 2.5) * cos((90 * i) * pi / 180);
      var ly = center.dy + (size.width / 2.5) * sin((90 * i) * pi / 180);
      canvas.drawLine(Offset(center.dx, center.dy), Offset(lx, ly), linesPaint);
    }
  }

  @override
  bool shouldRepaint(Clock1Painter oldDelegate) =>
      seconds != oldDelegate.seconds ||
      minutes != oldDelegate.minutes ||
      hours != oldDelegate.hours;
}
