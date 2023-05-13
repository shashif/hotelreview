// import 'package:flutter/material.dart';
//
// class AlreadyHaveAnAccountCheck extends StatelessWidget {
//
//   late final bool login;
//   late final VoidCallback press;
//
//   AlreadyHaveAnAccountCheck({this.login = true, required this.press})
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(login ? 'Don not have an account' : 'Already have an account',
//           style: TextStyle(
//             color: Colors.black54, fontStyle: FontStyle.italic,
//
//           ),),
//         GestureDetector(
//           onTap: press,
//           child: Text(login ? 'Sign Up' : 'Sign In', style: TextStyle(
//             color: Colors.black54, fontStyle: FontStyle.italic,
//
//           ),),
//         ),
//       ],
//     );
//   }
// }
