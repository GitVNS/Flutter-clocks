import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock1 extends StatefulWidget {
  const Clock1({super.key});

  @override
  State<Clock1> createState() => _Clock1State();
}

class _Clock1State extends State<Clock1> {
  var second = DateTime.now().second;
  var minute = DateTime.now().minute;
  var hour = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        DateTime dateTime = DateTime.now();
        second = dateTime.second * 6;
        minute = dateTime.minute * 6;
        hour = dateTime.hour * 30;
        setState(() {});
      }
    });

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
        SizedBox(
          width: 200,
          height: 200,
          child: CustomPaint(
            painter:
                Clock1Painter(seconds: second, minutes: minute, hours: hour),
          ),
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
      ..color = const Color(0xff8338ec)
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
