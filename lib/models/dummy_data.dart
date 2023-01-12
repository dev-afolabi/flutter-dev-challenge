import 'dart:math';

import 'transaction.dart';

class TransactionHelper {
  T _getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  Transaction generateTransaction(String amount, bool type) {
    return Transaction(
        amount: double.parse(amount),
        transactionDateTime: DateTime.now(),
        transactionType: type,
        bankName: _getRandomElement<String>(banks),
        customerName: _getRandomElement<String>(banks),
        ref: DateTime.now().millisecondsSinceEpoch.toString());
  }
}

const banks = [
  'Unitedbank of africa',
  'Firstbank of Nigeria',
  'Access bank plc',
  'Guarantee trust bank',
  'Zenith bank plc',
  'Sterling bank'
];

const customerNames = [
  'Kaiya Ramirez',
  'Austin Cannon',
  'Trace Bowen',
  'Chance Odonnell',
  'Josiah Bernard',
  'Laila Mays',
  'Lindsay Mccormick',
  'Sydnee Hammond',
  'Aditya Morales',
  'Nico Berg',
  'Israel Hull',
  'Lucas Beasley'
];

final dummyData = [
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  ),
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  ),
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  ),
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  ),
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  ),
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  ),
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  ),
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  ),
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  ),
  Transaction(
    amount: 2000,
    transactionDateTime: DateTime.now(),
    transactionType: true,
    bankName: 'Firstbank of Nigeria',
    customerName: 'William Johnson',
    ref: DateTime.now().millisecondsSinceEpoch.toString(),
  )
];
