import 'dart:async';
import 'dart:math';

import 'package:dev_challenge/providers/auth_provider.dart';
import 'package:dev_challenge/screens/auth_screen.dart';
import 'package:dev_challenge/widgets/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  Function toggleIsShown;
  SplashScreen({required this.toggleIsShown});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   widget.toggleIsShown();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }
}
