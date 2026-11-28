import 'package:flutter/material.dart';

Future<void> showAuthDialog(BuildContext context, {required String message}) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Closes the dialog
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
