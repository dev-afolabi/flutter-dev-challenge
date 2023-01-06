import 'package:flutter/material.dart';

import '../models/transactions.dart';
import '../widgets/select_transaction.dart';
import '../models/dummy_data.dart';
import 'bottom_nav.dart';
import 'transaction_list.dart';
import '../widgets/dashboard.dart';
import '../widgets/quick_links.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> transactions = dummyData;

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(17),
            topRight: Radius.circular(17),
          ),
        ),
        context: context,
        builder: (_) {
          return SelectTransactionModal(
            transactions: transactions,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Dashboard(),
          QuickLinks(),
          TransactionList(
            transactions: transactions.reversed.toList(),
          ),
          BottomNav(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
