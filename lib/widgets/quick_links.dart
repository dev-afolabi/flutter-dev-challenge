import 'package:dev_challenge/widgets/input_withdrawal_screen.dart';
import 'package:flutter/material.dart';

import 'input_transaction_details_screen.dart';

class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 139,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 12,
              bottom: 4,
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quick Transaction',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 70,
            width: 360,
            decoration: BoxDecoration(
              color: Color(0xFFe8f0fa),
              border: Border.all(color: Color(0xffB1C1E9)),
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ), //border corner radius
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ), //border corner radius
                      ),
                      child: InkWell(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff123CAA),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ), //border corner radius
                                ),
                                child: Image.asset(
                                  'assets/icons/mingcute_transfer.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              'Payment',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return InputTransactionDetails();
                            }),
                          );
                        },
                      )),
                  Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ), //border corner radius
                    ),
                    child: InkWell(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Container(
                              height: 60,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff123CAA),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ), //border corner radius
                              ),
                              child: Image.asset(
                                'assets/icons/ph_credit-card.png',
                              ),
                            ),
                          ),
                          Text(
                            'Withdraw',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return InputWithdrawalDetails();
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              alignment: Alignment.center,
              width: 360,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 34, 27, 233)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
