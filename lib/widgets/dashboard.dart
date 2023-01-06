import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
                const Text(
                  '#275,000.00',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
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
}
