import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/transactions_provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Transactions>(context).transactions;
    return Expanded(
        child: Container(
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: 2,
          bottom: 3,
          left: 12,
          right: 12,
        ),
        itemBuilder: (ctx, index) {
          return Container(
            height: 70,
            child: Card(
              margin: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          border: Border.all(
                            color: Colors.green,
                          ), //border corner radius
                        ),
                        child: Image.asset(
                          'assets/icons/mdi_database-arrow-down-outline.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
                    alignment: Alignment.centerLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].customerName,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            transactions[index].bankName,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            transactions[index].ref,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 9,
                    ),
                    width: 90,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            transactions[index].amount.toString(),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            DateFormat('EEEE, d MMM y').format(
                                transactions[index].transactionDateTime),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            DateFormat().add_jm().format(
                                transactions[index].transactionDateTime),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    ));
  }
}
