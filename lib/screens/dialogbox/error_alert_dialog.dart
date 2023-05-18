import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  late final String message;

  ErrorAlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.pushReplacement(context,
        //           MaterialPageRoute(builder: (context) => AnyScreen()));
        //     },
        //     child: Center(
        //       child: Text('Ok'),
        //     )),
      ],
    );
  }
}
