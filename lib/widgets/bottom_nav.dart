import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 73,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ), //border corner radius
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1), //color of shadow
              spreadRadius: 5, //spread radius
              blurRadius: 7, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
              blurStyle: BlurStyle.outer),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 37, vertical: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/icons/majesticons_home-analytics.png',
                width: 23,
                height: 23,
                fit: BoxFit.cover,
              ),
              const Text(
                'Home',
                style: TextStyle(color: Color(0xff123CAA)),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                'assets/icons/mingcute_transfer-3-line.png',
                width: 23,
                height: 23,
                fit: BoxFit.cover,
                color: Colors.grey,
              ),
              const Text(
                'Transactions',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                'assets/icons/ph_user-light.png',
                width: 23,
                height: 23,
                color: Colors.grey,
                fit: BoxFit.cover,
              ),
              const Text('Profile', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
