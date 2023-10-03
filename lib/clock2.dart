import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock2 extends StatefulWidget {
  const Clock2({super.key});

  @override
  State<Clock2> createState() => _Clock2State();
}

class _Clock2State extends State<Clock2> {
  var second = DateTime.now().second;
  var minute = DateTime.now().minute;
  var hour = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      DateTime dateTime = DateTime.now();
      second = dateTime.second * 6;
      minute = dateTime.minute * 6;
      hour = dateTime.hour * 30;
      setState(() {});
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
                Clock2Painter(seconds: second, minutes: minute, hours: hour),
          ),
        ),
      ],
    );
  }
}

class Clock2Painter extends CustomPainter {
  final int seconds;
  final int minutes;
  final int hours;
  Clock2Painter(
      {required this.seconds, required this.minutes, required this.hours});

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);

    Paint secondsPaint = Paint()..color = const Color(0xffc1121f);
    Paint minutesPaint = Paint()..color = const Color(0xff669bbc);
    Paint hoursPaint = Paint()..color = const Color(0xfffdf0d5);

    var sx = center.dx + (size.width / 2) * cos((270 + seconds) * pi / 180);
    var sy = center.dy + (size.width / 2) * sin((270 + seconds) * pi / 180);
    canvas.drawCircle(Offset(sx, sy), size.width * 0.045, secondsPaint);
    canvas.drawCircle(
        center,
        size.width / 2,
        secondsPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.015);

    var mx = center.dx + (size.width / 2.7) * cos((270 + minutes) * pi / 180);
    var my = center.dy + (size.width / 2.7) * sin((270 + minutes) * pi / 180);
    canvas.drawCircle(Offset(mx, my), size.width * 0.045, minutesPaint);
    canvas.drawCircle(
        center,
        size.width / 2.7,
        minutesPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.015);

    var hx = center.dx + (size.width / 5) * cos((270 + hours) * pi / 180);
    var hy = center.dy + (size.width / 5) * sin((270 + hours) * pi / 180);
    canvas.drawCircle(Offset(hx, hy), size.width * 0.045, hoursPaint);
    canvas.drawCircle(
        center,
        size.width / 5,
        hoursPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.015);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
