// import 'package:flutter/material.dart';
//
// class RoundedButton extends StatelessWidget {
//
//   late final String text;
//   late final VoidCallback press;
//   late final Color color, textColot;
//
//   RoundedButton({
//     required this.text,
//     required this.press,
//     this.color = Colors.black,
//     this.textColot = Colors.white
//   })
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery
//         .of(context)
//         .size;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 1),
//       width: size.width * 0.7,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(29),
//         child: ElevatedButton(
//           child: Text(text, style: TextStyle(
//             color: textColot,
//           )),
//           onPressed: press,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: color,
//             padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
//           ),
//         ),
//
//       ),
//     );
//   }
// }
