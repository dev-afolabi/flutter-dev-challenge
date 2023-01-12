import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../providers/auth_provider.dart';
import '../providers/transactions_provider.dart';
import '../widgets/select_transaction.dart';
import '../models/dummy_data.dart';
import 'bottom_nav.dart';
import 'transaction_list.dart';
import '../widgets/dashboard.dart';
import '../widgets/quick_links.dart';

class HomeScreen extends StatelessWidget {
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
          return SelectTransactionModal();
        });
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Dashboard(),
            QuickLinks(),
            TransactionList(),
            BottomNav(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => startAddNewTransaction(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
