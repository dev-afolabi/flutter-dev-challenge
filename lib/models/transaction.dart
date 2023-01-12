class Transaction {
  double amount;
  DateTime transactionDateTime;
  bool transactionType;
  String customerName;
  String bankName;
  String ref;

  Transaction({
    required this.amount,
    required this.transactionDateTime,
    required this.transactionType,
    required this.bankName,
    required this.customerName,
    required this.ref,
  });
}
