import 'package:flutter/material.dart';

class inputTransactionDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xffebeef4),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 80,
              margin: EdgeInsets.only(top: 50),
              child: CloseButton(),
            ),
            Container(
              child: Column(
                children: [
                  Column(
                    children: [
                      Text('Amount (Naira)'),
                      TextField(),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Description'),
                      TextField(),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: null,
              child: Text('Confirm'),
            )
          ],
        ),
      ),
    );
  }
}
