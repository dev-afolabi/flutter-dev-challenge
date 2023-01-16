import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../providers/transactions_provider.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  var isInit = true;
  var isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Transactions>(context).getTransaction().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final transactions =
        Provider.of<Transactions>(context).transactions.reversed.toList();
    return isLoading
        ? Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        : transactions.isEmpty
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
                    height: 80,
                    margin: EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 0.15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              border: Border.all(
                                color: transactions[index].transactionType
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
                        Container(
                          width: 150,
                          padding: EdgeInsets.only(top: 10),
                          alignment: Alignment.centerLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactions[index].customerName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  transactions[index].bankName,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  transactions[index].ref,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 9, top: 6),
                            width: 90,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    NumberFormat('#,##0.0')
                                        .format(transactions[index].amount),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    DateFormat('EEE, d MMM y').format(
                                        transactions[index]
                                            .transactionDateTime),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    DateFormat().add_jm().format(
                                        transactions[index]
                                            .transactionDateTime),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  );

                  //Card(
                  //margin: EdgeInsets.all(2),
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8),
                  //       child: Container(
                  //         padding: EdgeInsets.all(8),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(50),
                  //           ),
                  //           border: Border.all(
                  //             color:
                  //                 transactions[index].transactionType
                  //                     ? Colors.green
                  //                     : Colors.red,
                  //           ), //border corner radius
                  //         ),
                  //         child: Image.asset(
                  //           transactions[index].transactionType
                  //               ? 'assets/icons/mdi_database-arrow-down-outline.png'
                  //               : 'assets/icons/mdi_database-arrow-up-outline.png',
                  //           width: 20,
                  //           height: 20,
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       width: 220,
                  //       alignment: Alignment.centerLeft,
                  //       child: Column(
                  //           crossAxisAlignment:
                  //               CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               transactions[index].customerName,
                  //               style: TextStyle(
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //             Text(
                  //               transactions[index].bankName,
                  //               style: TextStyle(
                  //                 fontSize: 12,
                  //               ),
                  //             ),
                  //             Text(
                  //               transactions[index].ref,
                  //               style: TextStyle(
                  //                 fontSize: 12,
                  //               ),
                  //             ),
                  //           ]),
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.only(
                  //         right: 9,
                  //       ),
                  //       width: 90,
                  //       child: Column(
                  //           crossAxisAlignment:
                  //               CrossAxisAlignment.end,
                  //           children: [
                  //             Text(
                  //               transactions[index].amount.toString(),
                  //               style: TextStyle(
                  //                 fontSize: 14,
                  //               ),
                  //             ),
                  //             Text(
                  //               DateFormat('EEEE, d MMM y').format(
                  //                   transactions[index]
                  //                       .transactionDateTime),
                  //               style: TextStyle(
                  //                 fontSize: 12,
                  //               ),
                  //             ),
                  //             Text(
                  //               DateFormat().add_jm().format(
                  //                   transactions[index]
                  //                       .transactionDateTime),
                  //               style: TextStyle(
                  //                 fontSize: 12,
                  //               ),
                  //             ),
                  //           ]),
                  //     ),
                  //   ],
                  // ),
                  //),
                },
                itemCount: transactions.length,
              ));
  }
}
