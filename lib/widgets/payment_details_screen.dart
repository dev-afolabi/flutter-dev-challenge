import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../providers/transactions_provider.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({super.key});

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

      final addTrans = (ModalRoute.of(context)?.settings.arguments
          as Map<String, Object>)['addTrx'] as Function;
      // Provider.of<Transactions>(context).addTransaction(context,
      //     routeArgs['trx'] as Transaction, routeArgs['amount'] as String);
      print(routeArgs['transaction']);
      addTrans(routeArgs['transaction'] as Transaction,
          routeArgs['amount'] as String);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  String generateAccountNumber() {
    var rng = Random();
    var l = List.generate(8, (_) => rng.nextInt(10));

    return l.join("");
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    final addTrans = (ModalRoute.of(context)?.settings.arguments
        as Map<String, Object>)['addTrx'];

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
                            color: Color(0xff696969),
                          ),
                        ),
                        Text(
                          'Dev Challenge',
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
                        Text('75' + generateAccountNumber()),
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
                        Text('Parkway dev'),
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
                        Text(routeArgs['amount'] as String),
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
                  onPressed: () {},
                  child: Text('Share'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
