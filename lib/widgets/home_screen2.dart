import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'quick_links.dart';
import 'transaction_list.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Dashboard(),
        QuickLinks(),
        TransactionList(),
      ],
    );
  }
}
