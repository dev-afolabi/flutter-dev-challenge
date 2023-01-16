import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/transactions_provider.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Transactions>(context).transactions;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 90,
          color: Color(0xffebeef4),
          margin: EdgeInsets.only(top: 60, bottom: 20),
          child: Row(
            children: [
              BackButton(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Transactions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text('Transactions on your wallet',
                      style: TextStyle(fontSize: 14)),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Color(0xff123CAA),
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    right: 28,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    'All',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Color(0xff123CAA),
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    right: 28,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    'Credit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Color(0xff123CAA),
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    right: 28,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    'Debit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        transactions.isEmpty
            ? Expanded(
                child: Center(
                  child: Text(
                    'No transactions yet',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            : Expanded(
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
                      child: transactions.isEmpty
                          ? Container(
                              child: Text('No transactions yet.'),
                            )
                          : Card(
                              margin: EdgeInsets.all(2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            color: transactions[index]
                                                    .transactionType
                                                ? Colors.green
                                                : Colors.red,
                                          ), //border corner radius
                                        ),
                                        child: Image.asset(
                                          transactions[index].transactionType
                                              ? 'assets/icons/mdi_database-arrow-down-outline.png'
                                              : 'assets/icons/mdi_database-arrow-up-outline.png',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            transactions[index]
                                                .amount
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('EEEE, d MMM y').format(
                                                transactions[index]
                                                    .transactionDateTime),
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            DateFormat().add_jm().format(
                                                transactions[index]
                                                    .transactionDateTime),
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
              ),
      ],
    );
  }
}
