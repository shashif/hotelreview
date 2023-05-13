import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_review/widgets/color_widget.dart';

import '../../auth/sing_in.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SingIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.orange,
          Colors.teal,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 350,
              ),
            ),
            SizedBox(height: 20,),
            CircularProgressIndicator(),
            SizedBox(height: 20,),
            Center(
              child: Text('Booking your desire Hotel and Resort',
                style: TextStyle(
                  decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Verela',


              ),),
            ),

          ],
        ),
      ),
    );
  }
}
