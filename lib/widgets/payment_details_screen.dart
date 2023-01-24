import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../providers/transactions_provider.dart';

class PaymentDetailsPage extends StatefulWidget {
  //final String token;
  final Transaction trx;
  final String amount;
  const PaymentDetailsPage(
      {super.key, required this.amount, required this.trx});

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  bool isInit = true;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Transactions>(context)
          .addTransaction(widget.trx, widget.amount)
          .then((value) {
        isInit = false;
        _showSimpleModalDialog(context);
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  String generateAccountNumber() {
    var rng = Random();
    var list = List.generate(8, (_) => rng.nextInt(10));

    return list.join("");
  }

  void dash() {
    Navigator.of(context).pop();
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialog(trx: widget.trx, amount: widget.amount, home: dash);
        });
  }

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
                bottom: 50,
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
                        Text(widget.amount),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isLoading) CircularProgressIndicator(),
                  Text(
                    "account expires in 30",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  )
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

class MyDialog extends StatefulWidget {
  final Function home;
  final Transaction trx;
  final String amount;
  const MyDialog(
      {super.key, required this.amount, required this.trx, required this.home});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  void goTodashboard() {
    Navigator.of(context).pop();
    widget.home();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        width: double.infinity,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: CloseButton(
                    onPressed: goTodashboard,
                  ),
                ),
                Container(
                  height: 200,
                  //margin: EdgeInsets.only(t),
                  child: Center(
                    child: widget.trx.transactionType
                        ? Image.asset(
                            'assets/icons/Wallet_Flatline 2.png',
                          )
                        : Image.asset(
                            'assets/icons/Failed-Transaction.png',
                          ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.trx.transactionType
                        ? 'Payment Received!'
                        : 'Transaction failed!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: 290,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            "The sum of #${widget.amount} was succuessfuly paid into your account.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black,
                            wordSpacing: 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Container(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: goTodashboard,
                      child: Text(
                        widget.trx.transactionType
                            ? 'Go to dashboard'
                            : 'Retry',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
