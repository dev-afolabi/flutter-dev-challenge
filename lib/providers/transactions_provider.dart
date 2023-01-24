import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Transaction> _transactions = [];

  String authToken;
  String userId;
  bool loaded = false;

  Transactions(this.authToken, this.userId, this._transactions);

  List<Transaction> get transactions {
    return [..._transactions];
  }

  List<Transaction> get failedTransactions {
    return [..._transactions]
        .where((element) => element.transactionType == false)
        .toList();
  }

  List<Transaction> get successTransactions {
    return [..._transactions]
        .where((element) => element.transactionType == true)
        .toList();
  }

  double get balance {
    double amount = 0.0;
    transactions.where((trx) => trx.transactionType == true).forEach((trx) {
      amount += trx.amount;
    });

    return amount;
  }

  Future<void> getTransaction() async {
    final url = Uri.parse(
        'https://dev-challenge-c0501-default-rtdb.firebaseio.com/users/transactions.json?auth=$authToken&orderBy="userId"&equalTo="$userId"');
    try {
      final response = await http.get(url);
      var extractedData;
      try {
        extractedData = json.decode(response.body) as Map<String, dynamic>;
      } catch (e) {
        print('I caught the error');
      }
      final List<Transaction> loadedData = [];
      if (extractedData != null) {
        extractedData.forEach((transId, transData) {
          loadedData.add(
            Transaction(
              amount: transData['amount'],
              customerName: transData['customerName'],
              bankName: transData['bankName'],
              ref: transData['ref'],
              transactionType: transData['transactionType'],
              transactionDateTime: DateTime.parse(transData['transactionDate']),
            ),
          );
        });

        _transactions = loadedData;
        loaded = true;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTransaction(Transaction trx, String amount) async {
    final url = Uri.parse(
        'https://dev-challenge-c0501-default-rtdb.firebaseio.com/users/transactions.json?auth=$authToken');
    await http.post(
      url,
      body: json.encode({
        'bankName': trx.bankName,
        'amount': trx.amount,
        'transactionDate': trx.transactionDateTime.toString(),
        'transactionType': trx.transactionType,
        'customerName': trx.customerName,
        'ref': trx.ref,
        'userId': userId
      }),
    );
    _transactions.add(trx);
    notifyListeners();
  }
}
