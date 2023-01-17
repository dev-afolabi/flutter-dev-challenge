import 'dart:async';
import 'dart:math';

import 'package:dev_challenge/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => StartScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff123CAA),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                height: 155,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Splashline.png'),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Parkpay',
                  style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(pi),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: Container(
                    width: double.infinity,
                    height: 155,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Splashline.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
