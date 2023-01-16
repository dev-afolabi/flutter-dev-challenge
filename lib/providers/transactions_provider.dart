import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/dummy_data.dart';
import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Transaction> _transactions;

  String authToken;
  String userId;
  bool loaded = false;

  Transactions(this.authToken, this.userId, this._transactions);

  List<Transaction> get transactions {
    return [..._transactions].reversed.toList();
  }

  String get balance {
    double amount = 0.0;
    transactions.forEach((element) {
      amount += element.amount;
    });
    var formatter = NumberFormat('#,##0.00');
    return formatter.format(amount);
  }

  Future<void> getTransaction() async {
    final url = Uri.parse(
        'https://dev-challenge-c0501-default-rtdb.firebaseio.com/users/transactions.json?auth=$authToken&orderBy="userId"&equalTo="$userId"');
    try {
      print('this is he authtoken: ' + authToken);
      print('makin the get request');
      final response = await http.get(url);
      print(response);
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
    await http
        .post(
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
    )
        .then((response) {
      _transactions = [..._transactions, trx];
      notifyListeners();
    });
  }
}
