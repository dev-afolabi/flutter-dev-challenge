import 'package:flutter/material.dart';

// KeyPad widget
class NumPad extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPad({
    Key? key,
    this.buttonSize = 60,
    this.buttonColor = Colors.indigo,
    this.iconColor = Colors.amber,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 50),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // implement the number keys (from 0 to 9) with the NumberButton widget
                  // the NumberButton widget is defined in the bottom of this file
                  children: [
                    NumberButton(
                      number: 1,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                    NumberButton(
                      number: 2,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                    NumberButton(
                      number: 3,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NumberButton(
                      number: 4,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                    NumberButton(
                      number: 5,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                    NumberButton(
                      number: 6,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NumberButton(
                      number: 7,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                    NumberButton(
                      number: 8,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                    NumberButton(
                      number: 9,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // this button is used to delete the last number
                    SizedBox(
                      // height: buttonSize,
                      width: buttonSize,
                    ),
                    NumberButton(
                      number: 0,
                      size: buttonSize,
                      color: buttonColor,
                      controller: controller,
                    ),
                    IconButton(
                      onPressed: () => delete(),
                      icon: Icon(
                        Icons.backspace,
                        color: iconColor,
                      ),
                      iconSize: buttonSize,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                side: BorderSide(
                  width: 1.0,
                  color: Color(0xff123CAA),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(3),
                child: Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                controller.clear();
                print(controller.text);
              },
            ),
          )
        ],
      ),
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size / 2),
              side: BorderSide(
                width: 0.7,
                color: const Color(0xff123CAA),
              )),
        ),
        onPressed: () {
          controller.text += number.toString();
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff123CAA),
                fontSize: 30),
          ),
        ),
      ),
    );
  }
}
