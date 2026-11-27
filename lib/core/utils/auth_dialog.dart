
import 'package:flutter/material.dart';

Future<void> showAuthDialog(
    BuildContext context, {
      required String message,
    }) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content:  Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: const Text('Ok',style: TextStyle(fontSize: 15,color: Color(0xffF6D96B)),),
          ),
        ],
      );
    },
  );
}
