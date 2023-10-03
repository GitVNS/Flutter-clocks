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
      if (mounted) {
        DateTime dateTime = DateTime.now();
        second = dateTime.second * 6;
        minute = dateTime.minute * 6;
        hour = dateTime.hour * 30;
        setState(() {});
      }
    });

    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: Clock2Painter(seconds: second, minutes: minute, hours: hour),
      ),
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

    Paint bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xff0077b6),
          Colors.black,
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ).createShader(Rect.fromCenter(
          center: center, width: size.width, height: size.height));
    canvas.drawCircle(center, size.width / 2, bgPaint);
    canvas.drawCircle(
        center,
        size.width / 2,
        Paint()
          ..color = Colors.white.withOpacity(0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);

    draw12(canvas: canvas, size: size);
    draw3(canvas: canvas, size: size);
    draw6(canvas: canvas, size: size);
    draw9(canvas: canvas, size: size);

    Paint secondsPaint = Paint()
      ..color = const Color(0xfffb8500)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.01;
    var sx = center.dx + (size.width / 3) * cos((270 + seconds) * pi / 180);
    var sy = center.dy + (size.width / 3) * sin((270 + seconds) * pi / 180);
    canvas.drawLine(center, Offset(sx, sy), secondsPaint);

    Paint minutesPaint = Paint()
      ..color = const Color(0xffffeedd).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.03;
    var mx = center.dx + (size.width / 4) * cos((270 + minutes) * pi / 180);
    var my = center.dy + (size.width / 4) * sin((270 + minutes) * pi / 180);
    canvas.drawLine(center, Offset(mx, my), minutesPaint);

    Paint hoursPaint = Paint()
      ..color = const Color(0xffffeedd).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.02;
    var hx = center.dx + (size.width / 5) * cos((270 + hours) * pi / 180);
    var hy = center.dy + (size.width / 5) * sin((270 + hours) * pi / 180);
    canvas.drawLine(center, Offset(hx, hy), hoursPaint);

    canvas.drawCircle(center, size.width * 0.03, Paint()..color = Colors.white);
  }

  draw12({required Canvas canvas, required Size size}) {
    const text = '12';
    final textSpan = TextSpan(
        text: text,
        style: TextStyle(
          color: const Color(0xffffeedd),
          fontSize: size.width * 0.15,
          fontWeight: FontWeight.w900,
        ));
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final x = (size.width - textPainter.width) / 2;
    final y = ((size.height * 0.25) - textPainter.height) / 2;
    textPainter.paint(canvas, Offset(x, y));
  }

  draw3({required Canvas canvas, required Size size}) {
    const text = '3';
    final textSpan = TextSpan(
        text: text,
        style: TextStyle(
          color: const Color(0xffffeedd),
          fontSize: size.width * 0.15,
          fontWeight: FontWeight.w900,
        ));
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final x = ((size.width * 0.95) - textPainter.width);
    final y = (size.height - textPainter.height) / 2;
    textPainter.paint(canvas, Offset(x, y));
  }

  draw6({required Canvas canvas, required Size size}) {
    const text = '6';
    final textSpan = TextSpan(
        text: text,
        style: TextStyle(
          color: const Color(0xffffeedd),
          fontSize: size.width * 0.15,
          fontWeight: FontWeight.w900,
        ));
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final x = (size.width - textPainter.width) / 2;
    final y = ((size.height * 0.95) - textPainter.height);
    textPainter.paint(canvas, Offset(x, y));
  }

  draw9({required Canvas canvas, required Size size}) {
    const text = '9';
    final textSpan = TextSpan(
        text: text,
        style: TextStyle(
          color: const Color(0xffffeedd),
          fontSize: size.width * 0.15,
          fontWeight: FontWeight.w900,
        ));
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final x = ((size.width * 0.25) - textPainter.width) / 2;
    final y = (size.height - textPainter.height) / 2;
    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
