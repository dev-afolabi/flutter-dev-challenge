import 'package:flutter/material.dart';

import '../models/dummy_data.dart';
import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Transaction> _transactions = dummyData;

  List<Transaction> get transactions {
    return [..._transactions].reversed.toList();
  }

  void addTransaction(BuildContext ctx, Transaction trx, String amount) {
    _transactions.add(trx);
    notifyListeners();
    Navigator.of(ctx).pushNamed(
      'payment-details-page',
      arguments: {'amount': amount},
    );
  }
}
