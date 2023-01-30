import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../providers/transactions_provider.dart';

class OnlyBottomCursor extends StatefulWidget {
  final TextEditingController pinInputController;
  const OnlyBottomCursor({Key? key, required this.pinInputController})
      : super(key: key);

  @override
  _OnlyBottomCursorState createState() => _OnlyBottomCursorState();

  @override
  String toStringShort() => 'With Bottom Cursor';
}

class _OnlyBottomCursorState extends State<OnlyBottomCursor> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    // controller.dispose();
    //widget.pinInputController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color.fromRGBO(30, 60, 87, 1);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: const BoxDecoration(),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    return Pinput(
        length: 4,
        pinAnimationType: PinAnimationType.slide,
        controller: widget.pinInputController,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        errorPinTheme: focusedPinTheme,
        showCursor: true,
        cursor: cursor,
        preFilledWidget: preFilledWidget,
        validator: (pin) {
          if (pin == Provider.of<Transactions>(context, listen: false).pin) {
            return null;
          }

          /// Text will be displayed under the Pinput
          return 'Pin is incorrect';
        });
  }
}
