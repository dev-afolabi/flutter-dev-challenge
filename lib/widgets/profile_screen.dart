import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120,
            color: Color(0xff123CAA),
            margin: EdgeInsets.only(top: 60, bottom: 20),
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'My account',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text('wallet ID:',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
