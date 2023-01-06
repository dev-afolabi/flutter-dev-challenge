import 'package:flutter_guid/flutter_guid.dart';

class Transaction {
  Guid id;
  double amount;
  DateTime transactionDateTime;
  bool transactionType;
  String customerName;
  String bankName;
  String ref;

  Transaction({
    required this.id,
    required this.amount,
    required this.transactionDateTime,
    required this.transactionType,
    required this.bankName,
    required this.customerName,
    required this.ref,
  });
}
