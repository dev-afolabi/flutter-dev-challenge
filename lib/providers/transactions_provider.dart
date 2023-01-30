import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Transaction> _transactions = [];
  // ignore: prefer_final_fields
  List<Map<String, Object>> _banks = [
    {
      'bank': 'First Bank of Nigeria',
      'Details': [
        {'Name': 'Francisca Unegbu', 'AccNo': '306542654'}
      ]
    },
    // {'Zenith Bank Plc',}
    // {'Guarantee Trust Bank',}
    // {'United Bank For Africa'}
  ];

  String authToken;
  String userId;
  bool loaded = false;

  Transactions(this.authToken, this.userId, this._transactions);

  List<Transaction> get transactions {
    return [..._transactions];
  }

  List<String> get banks {
    return _banks.map((e) => e['bank'] as String).toList();
  }

  String get pin {
    return '1234';
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
    transactions.forEach((trx) {
      amount += trx.amount;
    });

    return amount;
  }

  //Get the bank details

  Future<void> getBanks() async {
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

  Future<void> addTransaction(
      Transaction trx, String amount, String type) async {
    if (type == 'withdrawal') {
      if (balance < trx.amount) {
        //doTransaction(trx, amount);
        throw Exception('Insufficient funds');
      }
      trx.amount = trx.amount * -1;
      doTransaction(trx, amount);
    }
    if (type == 'deposit') {
      doTransaction(trx, amount);
    }
  }

  Future<void> doTransaction(Transaction trx, String amount) async {
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

  // Future<void> withdrawalTransaction(Transaction trx, String amount) async {
  //   if()
  //   final url = Uri.parse(
  //       'https://dev-challenge-c0501-default-rtdb.firebaseio.com/users/transactions.json?auth=$authToken');
  //   await http.post(
  //     url,
  //     body: json.encode({
  //       'bankName': trx.bankName,
  //       'amount': trx.amount,
  //       'transactionDate': trx.transactionDateTime.toString(),
  //       'transactionType': trx.transactionType,
  //       'customerName': trx.customerName,
  //       'ref': trx.ref,
  //       'userId': userId
  //     }),
  //   );
  //   _transactions.add(trx);
  //   notifyListeners();
  // }
}
