import 'dart:math';
import 'package:dev_challenge/widgets/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../providers/auth_provider.dart';
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
  void didChangeDependencies() async {
    if (isInit) {
      await Provider.of<Transactions>(context)
          .addTransaction(widget.trx, widget.amount);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void goTodashboard() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ChangeNotifierProxyProvider<Auth, Transactions>(
        create: ((context) => Transactions('', '', [])),
        update: ((_, authToken, previousTransactions) => Transactions(
            authToken.token as String,
            authToken.userId as String,
            previousTransactions == null
                ? []
                : previousTransactions.transactions)),
        child: HomeScreen(),
      ),
    ));
  }

  String generateAccountNumber() {
    var rng = Random();
    var l = List.generate(8, (_) => rng.nextInt(10));

    return l.join("");
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 350),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                              wordSpacing: 1)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final routeArgs =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    // final addTrans = (ModalRoute.of(context)?.settings.arguments
    //     as Map<String, Object>)['addTrx'];

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
                        Text(widget.amount as String),
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
                  //CircularProgressIndicator(),
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
                  onPressed: goTodashboard,
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
