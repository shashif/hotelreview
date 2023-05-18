import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../dialogbox/error_alert_dialog.dart';
import '../splash_screen/splash_screen.dart';
import 'forget_background.dart';

class ForgetPassword extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
          ),
          SizedBox(height: 20,),
          MaterialButton(child: Text('Reset now'), onPressed: () async{

            try{
              await firebaseAuth.sendPasswordResetEmail(email: emailController.text);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
            }
            catch(error){
              ErrorAlertDialog(message:error.toString() ,);
            }
          }),
        ]
      ),
    );
  }
}
