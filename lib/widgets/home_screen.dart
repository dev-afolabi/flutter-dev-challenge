import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../providers/auth_provider.dart';
import '../providers/transactions_provider.dart';
import '../widgets/select_transaction.dart';
import '../models/dummy_data.dart';
import 'bottom_nav.dart';
import 'home_screen2.dart';
import 'profile_screen.dart';
import 'transaction_list.dart';
import '../widgets/dashboard.dart';
import '../widgets/quick_links.dart';
import 'transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeScreen2(),
    TransactionsScreen(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/majesticons_home-analytics.png',
                width: 23,
                height: 23,
                fit: BoxFit.cover,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.no_accounts_rounded),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => startAddNewTransaction(context),
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}
