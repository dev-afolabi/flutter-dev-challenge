import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../providers/transactions_provider.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int _position = 0;
  var isInit = true;
  var hidden = false;

  late AnimationController _controller;
  // @override
  // void didChangeDependencies() {
  //   if (isInit) {
  //     _controller = AnimationController(
  //       vsync: this,
  //       duration: Duration(milliseconds: 300),
  //     );
  //     _controller.addListener(() {
  //       if (_controller.value == 1.0) {
  //         setState(() {
  //           _position = (_position + 1) % 3;
  //         });
  //         _controller.reset();
  //         _controller.forward();
  //       }
  //     });
  //     _controller.forward();
  //   }
  //   isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    if (isInit) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      );
      _controller.addListener(() {
        if (_controller.value == 1.0) {
          setState(() {
            _position = (_position + 1) % 3;
          });
          _controller.reset();
          _controller.forward();
        }
      });
      _controller.forward();
    }
    isInit = false;
    super.initState();
  }

  void toggleHidden() {
    setState(() {
      hidden = !hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 265,
      decoration: const BoxDecoration(
        color: Color(0xff123CAA),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 18, right: 24.8, top: 63, bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back,',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text(
                          'West',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Image.asset(
                          'assets/icons/mdi_hand-wave-outline.png',
                          width: 18.33,
                          height: 18.33,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset(
                  'assets/icons/clarity_notification-outline-badged.png',
                  width: 26.5,
                  height: 27,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 155,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Lines_2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'current balance',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Provider.of<Transactions>(context).loaded
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          !hidden
                              ? Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/naira.png',
                                      width: 26,
                                      height: 46,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      NumberFormat('#,##0.00').format(
                                          Provider.of<Transactions>(context)
                                              .balance),
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Text('XXXXXXX',
                                  style: TextStyle(
                                    fontSize: 36,
                                    color: Colors.white,
                                  )),
                          GestureDetector(
                            onTap: toggleHidden,
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Image.asset(
                                hidden
                                    ? 'assets/icons/EyeHidden.png'
                                    : 'assets/icons/ph_eye-light.png',
                                width: 18.33,
                                height: 18.33,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      )
                    : DotsIndicator(
                        dotsCount: 3,
                        position: _position.toDouble(),
                        decorator: DotsDecorator(
                          color: Colors.white,
                          activeColor: Colors.white,
                          size: Size(10, 10),
                          activeSize: Size(15, 15),
                          spacing: EdgeInsets.all(8),
                        ),
                      ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Text(
                    DateFormat('EEEE, d MMMM').format(
                      DateTime.now(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
