import 'package:dev_challenge/widgets/pin_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pinput/pinput.dart';

import '../models/transaction.dart';
import '../providers/auth_provider.dart';
import '../providers/transactions_provider.dart';
import 'num_pad.dart';

class InputWithdrawalDetails extends StatefulWidget {
  const InputWithdrawalDetails({super.key});

  @override
  State<InputWithdrawalDetails> createState() => _InputWithdrawalDetailsState();
}

class _InputWithdrawalDetailsState extends State<InputWithdrawalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final amountInputController = TextEditingController();
  final accountNumberInputController = TextEditingController();
  final remarksInputController = TextEditingController();
  final TextEditingController _myController = TextEditingController();
  Transaction? trx;
  var fetchDetails = false;
  var called = false;
  var acCalled = false;
  String itemSelected = '';

  Future<void> _makeTransaction(BuildContext ctx) {
    trx = Transaction(
        amount: double.parse(amountInputController.text),
        transactionDateTime: DateTime.now(),
        transactionType: false,
        bankName: itemSelected,
        customerName: "Self",
        ref: DateTime.now().microsecond.toString());
    return Provider.of<Transactions>(context, listen: false).addTransaction(
        trx as Transaction, amountInputController.text, 'withdrawal');
  }

  // Future<void> _getDetails(BuildContext ctx) {
  //   return Provider.of<Transactions>(context, listen: false).getBankDetails(
  //       trx as Transaction, amountInputController.text, 'withdrawal');
  // }

  void gotoEnterPinPage(BuildContext ctx) {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                'Transaction PIN',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Text('Enter your 4 digit PIN'),
              OnlyBottomCursor(
                pinInputController: _myController,
              ),
              NumPad(
                buttonSize: 65,
                buttonColor: Colors.white,
                iconColor: Colors.deepOrange,
                controller: _myController,
                delete: () {
                  if (_myController.length != 0) {
                    _myController.text = _myController.text
                        .substring(0, _myController.text.length - 1);
                    called = false;
                  }
                },
                // do something with the input numbers
                onSubmit: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  void dash() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _myController.addListener(() {
      if (_myController.text.length == 4 && !called) {
        //Check pin
        if (Provider.of<Transactions>(context, listen: false).pin ==
            _myController.text) {
          //Make transaction
          _makeTransaction(context).then((value) {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return WithdrawalDialouge(
                    trx: trx as Transaction,
                    home: dash,
                  );
                });
          });
        } else {}

        called = true;
      }
      if (_myController.text.length > 4) {
        _myController.text =
            _myController.text.substring(0, _myController.text.length - 1);
      }
    });

    accountNumberInputController.addListener(() {
      if (accountNumberInputController.text.length == 10 && !acCalled) {
        //Check pin
        if (Provider.of<Transactions>(context, listen: false).pin ==
            _myController.text) {
        } else {}

        acCalled = true;
      }
      if (accountNumberInputController.text.length > 4) {
        accountNumberInputController.text = accountNumberInputController.text
            .substring(0, _myController.text.length - 1);
      }
    });

    return ChangeNotifierProxyProvider<Auth, Transactions>(
      update: ((_, authToken, previousTransactions) => Transactions(
          authToken.token as String,
          authToken.userId as String,
          previousTransactions == null
              ? []
              : previousTransactions.transactions)),
      create: (_) => Transactions('', '', []),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Color(0xffebeef4),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 80,
                  margin: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Receive payment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Enter amount below',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                        CloseButton(),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 10,
                        ),
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text('Bank'),
                            ),
                            SizedBox(
                              height: 56,
                              child: DropdownSearch<String>(
                                // we can pass string to it as well but then we've to make
                                // sure that the list of items are string like this List<String>
                                items: Provider.of<Transactions>(context).banks,
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                ),

                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  textAlignVertical: TextAlignVertical.center,
                                  dropdownSearchDecoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Select Bank now or never",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    prefixIcon: Container(
                                      padding: EdgeInsets.all(6),
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Color(0xff123CAA),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ), //border corner radius
                                      ),
                                      child: Image.asset(
                                        'assets/icons/ph_bank.png',
                                        height: 5,
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                ),

                                onChanged: (value) {
                                  setState(() {
                                    itemSelected = value.toString();
                                  });
                                },

                                selectedItem: itemSelected,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 10,
                        ),
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text('Account number'),
                            ),
                            SizedBox(
                              height: 57,
                              child: TextFormField(
                                  controller: accountNumberInputController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Enter Account number",
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Input a valid account number';
                                    }
                                    if (value.length < 10) {
                                      return 'Account number cannot be less than 10 digits';
                                    }
                                    if (value.length > 10) {
                                      return 'Account number cannot be greater than 10 digits';
                                    }
                                    return null;
                                  }),
                            ),
                            SizedBox(height: 7),
                            if (fetchDetails)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 7, bottom: 7),
                                decoration: BoxDecoration(
                                    color: const Color(0xff123CAA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 7),
                                      child: Image.asset(
                                        'assets/icons/check.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    Text(
                                      'Micheal afolabi johnson'.toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 10,
                        ),
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text('Amount (Naira)'),
                            ),
                            SizedBox(
                              height: 57,
                              child: TextFormField(
                                  controller: amountInputController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "# Enter Amount",
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Input a valid amount';
                                    }
                                    if (double.parse(value) < 500) {
                                      return 'Minimum amount of #500';
                                    }
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 10,
                        ),
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text('Remarks'),
                            ),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: remarksInputController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "What\'s this for (optional)",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () => gotoEnterPinPage(context),
                      child: Text('Withdraw'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WithdrawalDialouge extends StatefulWidget {
  final Function home;
  final Transaction trx;
  const WithdrawalDialouge({
    super.key,
    required this.trx,
    required this.home,
  });

  @override
  _WithdrawalDialougeState createState() => _WithdrawalDialougeState();
}

class _WithdrawalDialougeState extends State<WithdrawalDialouge> {
  void goTodashboard() {
    Navigator.of(context).pop();
    widget.home();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        width: double.infinity,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: CloseButton(
                    onPressed: goTodashboard,
                  ),
                ),
                Container(
                  height: 200,
                  child: Center(
                      child: Image.asset(
                    'assets/icons/Wallet_Flatline 2.png',
                  )),
                ),
                Center(
                  child: Text(
                    'Withdrawal Successful!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: 290,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            "The sum of #${widget.trx.amount} was succuessfuly withdrawn to your account.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black,
                            wordSpacing: 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Container(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: goTodashboard,
                      child: Text(
                        'Go to dashboard',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
