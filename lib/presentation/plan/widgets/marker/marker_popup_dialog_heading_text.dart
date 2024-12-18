import 'package:flutter/material.dart';

class MarkerPopupDialogHeadingText extends StatelessWidget {
  final String headingText;
  final bool isBold;

  const MarkerPopupDialogHeadingText(
      {Key? key, required this.headingText, required this.isBold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      headingText,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}
