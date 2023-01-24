import 'package:dev_challenge/models/dummy_data.dart';
import 'package:dev_challenge/widgets/payment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/transactions_provider.dart';

class InputTransactionDetails extends StatefulWidget {
  const InputTransactionDetails({super.key});

  @override
  State<InputTransactionDetails> createState() =>
      _InputTransactionDetailsState();
}

class _InputTransactionDetailsState extends State<InputTransactionDetails> {
  final amountInputController = TextEditingController();

  final descriptionInputController = TextEditingController();

  void generatePaymentDetails(BuildContext ctx, bool type) {
    var trx = TransactionHelper()
        .generateTransaction(amountInputController.text, type);
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(builder: (_) {
        return PaymentDetailsPage(
          amount: amountInputController.text,
          trx: trx,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<Auth, Transactions>(
      update: ((_, authToken, previousTransactions) => Transactions(
          authToken.token as String,
          authToken.userId as String,
          previousTransactions == null
              ? []
              : previousTransactions.transactions)),
      create: (_) => Transactions('', '', []),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
                              'Receive payment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Enter amount below',
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
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 30,
                        ),
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text('Amount (Naira)'),
                            ),
                            SizedBox(
                              child: TextField(
                                controller: amountInputController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Amount",
                                ),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text('Description'),
                            ),
                            SizedBox(
                              height: 310,
                              child: TextField(
                                controller: descriptionInputController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Description",
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
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
                      onLongPress: () => generatePaymentDetails(context, false),
                      onPressed: () => generatePaymentDetails(context, true),
                      child: Text('Confirm'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
