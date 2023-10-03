import 'package:custom_clock/clock1.dart';
import 'package:custom_clock/clock2.dart';
import 'package:custom_clock/clock3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Clock1(),
              SizedBox(width: 40),
              Clock2(),
              SizedBox(width: 40),
              Clock3(),
            ],
          ),
        ),
      ),
    );
  }
}
