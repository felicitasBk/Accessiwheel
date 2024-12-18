import 'package:flutter/material.dart';

//TODO: - Refactor later,  a builder might suite the case.
class AlertDialogManager {
  static void singleButtonDialog(BuildContext context, String title,
      String description, Function okAction) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(
          description,
          style: TextStyle(
            color: Colors.black, // Change the font color here
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              okAction();
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  static void twoButtonDialog(BuildContext context, String title,
      String description, Function okAction, Function cancelAction) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              cancelAction();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              okAction();
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
