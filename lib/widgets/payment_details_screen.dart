import 'package:flutter/material.dart';

class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key});

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
              margin: EdgeInsets.only(
                top: 50,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Make payment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Make transfer to the account details below',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    CloseButton(),
                  ],
                ),
              ),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(
                top: 8,
                bottom: 165,
                left: 15,
                right: 15,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.white,
                    height: 67,
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bank',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade50,
                          ),
                        ),
                        Text(
                          'test',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 67,
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Account number'),
                        Text('test'),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 67,
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Account name'),
                        Text('test'),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount'),
                        Text('test'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: null,
                  child: Text('Confirm'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
