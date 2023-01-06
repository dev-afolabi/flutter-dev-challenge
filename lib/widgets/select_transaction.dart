import 'package:flutter/material.dart';

import '../models/transactions.dart';
import './input_transaction_details_screen.dart';

class SelectTransactionModal extends StatelessWidget {
  final List<Transaction> transactions;

  const SelectTransactionModal({super.key, required this.transactions});

  void showTransactionInputForm(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return InputTransactionDetails(
          transactions: transactions,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 90),
                  child: Icon(Icons.arrow_back),
                ),
                Text(
                  'Select option',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Container(
              height: 85,
              width: 360,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Receive payment',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Receive payment via bank transfer',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () => showTransactionInputForm(context),
          ),
          InkWell(
            child: Container(
              height: 85,
              width: 360,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xff123CAA),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ), //border corner radius
                      ),
                      child: Image.asset(
                        'assets/icons/carbon_send-alt2.png',
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Make payment',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Send payment to bank account',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              print('This container was tapped anywhere');
            },
          ),
        ],
      ),
    );
  }
}
