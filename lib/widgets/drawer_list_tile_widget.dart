import 'package:flutter/material.dart';

class listTile extends StatelessWidget {
  listTile({Key? key, required this.iconData, required this.title, required this.onTap})
      : super(key: key);

  IconData iconData;
  String title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black45,
        ),
      ),
    );
    ;
  }
}
