import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/dummy_data.dart';
import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Transaction> _transactions;

  String authToken;
  String userId;

  Transactions(this.authToken, this.userId, this._transactions);

  List<Transaction> get transactions {
    return [..._transactions].reversed.toList();
  }

  Future<void> getTransaction() async {
    final url = Uri.parse(
        'https://dev-challenge-c0501-default-rtdb.firebaseio.com/transactions.json?auth=$authToken');
    try {
      print('this is he authtoken: ' + authToken);
      print('makin the get request');
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      final List<Transaction> loadedData = [];
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
      print('below is loaded data');
      print(loadedData);
      _transactions = loadedData;
      print('below is loaded data');
      print(_transactions);
      notifyListeners();
      print('I got to notify listeners');
      print(_transactions.length);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTransaction(Transaction trx, String amount) async {
    final url = Uri.parse(
        'https://dev-challenge-c0501-default-rtdb.firebaseio.com/transactions.json?auth=$authToken');
    var response = await http
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
      _transactions.add(trx);
      notifyListeners();
    });
  }
}
