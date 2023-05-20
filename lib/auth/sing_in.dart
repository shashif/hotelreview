import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../providers/BasicInfoProvider.dart';
import '../providers/user_provider.dart';
import '../screens/home_screen/home_screen.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  late UserProvider userProvider;

  _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;

      // print("signed in " + user.displayName);
      userProvider.addUserData(
        currentUser: user!,
        userEmail: user.email!,
        userImage: user.photoURL!,
        userName: user.displayName!,
      );

      return user;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    BasicInfoProvider basicInfoProvider = Provider.of(context);
    basicInfoProvider.readBasicAppInfo();

    String appsTitle = basicInfoProvider.basicInfoDataList.isNotEmpty
        ? basicInfoProvider.basicInfoDataList[0].appsTitle
        : '';
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Sign in to continue'),
                  Text(
                    appsTitle,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'Verela',
                        shadows: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: Offset(3, 3),
                            color: Colors.green.shade900,
                          ),
                        ]),
                  ),
                  // with custom text
                  Column(
                    children: [
                      SignInButton(
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () {
                          _googleSignUp().then(
                            (value) => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'By Sigining in you are agreeing to our ',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      Text(
                        'Terms and privacy policy ',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
