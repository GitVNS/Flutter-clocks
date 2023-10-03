import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock3 extends StatefulWidget {
  const Clock3({super.key});

  @override
  State<Clock3> createState() => _Clock3State();
}

class _Clock3State extends State<Clock3> {
  var second = DateTime.now().second;
  var minute = DateTime.now().minute;
  var hour = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        DateTime dateTime = DateTime.now();
        second = dateTime.second * 6;
        minute = dateTime.minute;
        hour = dateTime.hour;
        setState(() {});
      }
    });

    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: Clock3Painter(seconds: second, minutes: minute, hours: hour),
      ),
    );
  }
}

class Clock3Painter extends CustomPainter {
  final int seconds;
  final int minutes;
  final int hours;
  Clock3Painter(
      {required this.seconds, required this.minutes, required this.hours});

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    final pathsPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1;

    final secondsStrokePaint = Paint()
      ..color = const Color(0xffffd60a)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.08;
    final secondsPaint = Paint()..color = const Color(0xffffd60a);
    final secondsShadowPaint = Paint()
      ..color = const Color(0xffffd60a).withOpacity(0.7)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    var sx = center.dx + (size.width / 2) * cos((270 + seconds) * pi / 180);
    var sy = center.dy + (size.width / 2) * sin((270 + seconds) * pi / 180);
    Rect secondsRect =
        Rect.fromCenter(center: center, width: size.width, height: size.height);
    canvas.drawArc(secondsRect, 270 * pi / 180, seconds * pi / 180, false,
        secondsStrokePaint);
    canvas.drawArc(
        secondsRect, 270 * pi / 180, 360 * pi / 180, false, pathsPaint);
    canvas.drawCircle(Offset(sx, sy), size.width * 0.1, secondsShadowPaint);
    canvas.drawCircle(Offset(sx, sy), size.width * 0.04, secondsPaint);

    final text = '$hours:$minutes';
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: const Color(0xfffffcf2),
        fontSize: size.width * 0.25,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final x = (size.width - textPainter.width) / 2;
    final y = (size.height - textPainter.height) / 2;
    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(Clock3Painter oldDelegate) =>
      seconds != oldDelegate.seconds ||
      minutes != oldDelegate.minutes ||
      hours != oldDelegate.hours;
}
