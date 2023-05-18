import 'package:flutter/material.dart';
//cutomize method
circularProgress(){

  return Container(
    alignment: Alignment.center,
        padding: EdgeInsets.only(top: 12.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Colors.lightGreenAccent,

      ),
    ),
  );
}