import 'package:flutter/material.dart';
import 'package:hotel_review/widgets/circularProgress.dart';

class LoadingAlertDialog extends StatelessWidget {
  late String message;

  LoadingAlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          SizedBox(
            height: 10,
          ),
          Text('Please wait'),
        ],
      ),
    );
  }
}
