import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
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
                            widget.transactions[index].customerName,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.transactions[index].bankName,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            widget.transactions[index].ref,
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
                            widget.transactions[index].amount.toString(),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            DateFormat('EEEE, d MMM y').format(
                                widget.transactions[index].transactionDateTime),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            DateFormat().add_jm().format(
                                widget.transactions[index].transactionDateTime),
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
        itemCount: widget.transactions.length,
      ),
    ));
  }
}
