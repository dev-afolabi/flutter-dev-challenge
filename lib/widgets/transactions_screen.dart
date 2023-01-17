import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../providers/transactions_provider.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Transaction> allTransactions = [
      ...Provider.of<Transactions>(context).transactions
    ];
    List<Transaction> creditTransactions = [
      ...Provider.of<Transactions>(context).successTransactions
    ];
    List<Transaction> debitTransactions = [
      ...Provider.of<Transactions>(context).failedTransactions
    ];

    return Scaffold(
      body: Column(
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text('Transactions on your wallet',
                        style: TextStyle(fontSize: 14)),
                  ],
                )
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                height: 70,
                width: 370,
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  children: [
                    Container(
                        width: (370 / 3),
                        decoration: BoxDecoration(
                            border: Border(
                          right: BorderSide(
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                        ))),
                    Container(width: 370 / 3, decoration: BoxDecoration()),
                    Container(
                        width: 370 / 3,
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                        ))),
                  ],
                ),
              ),
              Container(
                height: 70,
                width: 370,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1),
                ),
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Successful'),
                    Tab(text: 'Failed'),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                TransactionsFilter(transactions: allTransactions),
                TransactionsFilter(transactions: creditTransactions),
                TransactionsFilter(transactions: debitTransactions),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionsFilter extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionsFilter({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: Text(
              'No transactions yet',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.builder(
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
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              transactions[index].bankName,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
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
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                DateFormat('EEE, d MMM y').format(
                                    transactions[index].transactionDateTime),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                DateFormat().add_jm().format(
                                    transactions[index].transactionDateTime),
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
            },
            itemCount: transactions.length,
          );
  }
}
