// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hotel_review/screens/dialogbox/loading_dialog.dart';
// import 'package:hotel_review/screens/home_screen/home_screen.dart';
// import 'package:hotel_review/widgets/global_var.dart';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
//
// import '../../models/user_model.dart';
// import '../../providers/user_provider.dart';
// import '../../widgets/color_widget.dart';
// import '../../widgets/drawer_widget.dart';
//
// class FreePostScreen extends StatefulWidget {
//   UserModel userData;
//
//   FreePostScreen({required this.userData});
//
//   @override
//   State<FreePostScreen> createState() => _FreePostScreenState();
// }
//
// class _FreePostScreenState extends State<FreePostScreen> {
//   String postID = Uuid().v4();
//   bool next = false;
//   bool uploading = false;
//   final List<File> _imagePath = [];
//
//   //String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//   List<String> imageUrlList = [];
//
//   // widget.userData.userName
//   String name = '';
//   String emailID = '';
//   double val = 0;
//
//   String itemPrice = '';
//   String itemTitle = '';
//   String phoneNumber = '';
//   String itemDescription = '';
//   String address = '';
//   bool isAdminApprove = false;
//
//   chooseImage() async {
//     XFile? pickedFile =
//     await ImagePicker().pickImage(source: ImageSource.gallery);
//     setState(() {
//       _imagePath.add(File(pickedFile!.path));
//     });
//   }
//
//   Future uploadFile() async {
//     int i = 1;
//     for (var img in _imagePath) {
//       setState(() {
//         val = i / _imagePath.length;
//       });
//
//       String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//       String fileExtension = Path.extension(img.path);
//       String fileName =
//           '${Path.basenameWithoutExtension(img.path)}$uniqueFileName$fileExtension';
//
//       var ref = FirebaseStorage.instance
//           .ref()
//       // .child('freePostImage/${Path.basename(img.path)}');
//           .child('FreePostImage/$fileName');
//       await ref.putFile(img).whenComplete(() async {
//         await ref.getDownloadURL().then((value) {
//           imageUrlList.add(value);
//           i++;
//         });
//       });
//     }
//   }
//
//   getNameOFUser() {
//     // FirebaseFirestore.instance
//     //     .collection('usersData')
//     //     .doc(uid)
//     //     .get()
//     //     .then((value) async {
//     //   if (value.exists) {
//     //     setState(() {
//     //       // name = value.data()!['userName'];
//     //       // emailID = value.data()!['userEmail'];
//     //
//     //
//     //     });
//     //   }
//     // });
//     // name = widget.userData.userName;
//     // emailID = widget.userData.userEmail;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     UserProvider userProvider = Provider.of(context);
//     userProvider.getUserData();
//     var userData = userProvider.currentUserData;
//     name = widget.userData.userName;
//     emailID = widget.userData.userEmail;
//     userImageURl = widget.userData.userImage;
//     return Scaffold(
//       backgroundColor: scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         elevation: 0.0,
//         title: Text(
//           next ? 'Please write Post details' : 'Choose the item images',
//           style: TextStyle(
//             fontSize: 18,
//             color: textColor,
//             fontFamily: 'Lobster',
//           ),
//         ),
//         actions: [
//           next
//               ? Container()
//               : ElevatedButton(
//               onPressed: () {
//                 if (_imagePath.length > 0) {
//                   setState(() {
//                     uploading = true;
//                     next = true;
//                   });
//                 } else {
//                   Fluttertoast.showToast(
//                       msg: 'Please Select minimum 1 picture',
//                       gravity: ToastGravity.CENTER);
//                 }
//               },
//               child: Text(
//                 'Next',
//                 style: TextStyle(
//                   fontFamily: "Verela",
//                   fontSize: 25,
//                 ),
//               )),
//         ],
//       ),
//       drawer: DrawerWidget(userProvider: userProvider),
//       body: next
//           ? SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(30),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: 'Enter  Price'),
//                 onChanged: (value) {
//                   itemPrice = value;
//                 },
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: 'Enter Title'),
//                 onChanged: (value) {
//                   itemTitle = value;
//                 },
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: 'Write details'),
//
//                 onChanged: (value) {
//                   itemDescription = value;
//                 },
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: 'Phone Number'),
//                 onChanged: (value) {
//                   phoneNumber = value;
//                 },
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: 'Address'),
//                 onChanged: (value) {
//                   address = value;
//                 },
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               // InkWell(
//               //   onTap: () {
//               //     Navigator.of(context).push(
//               //       MaterialPageRoute(
//               //         builder: (context) => CostomGoogleMap(),
//               //       ),
//               //     );
//               //   },
//               //   child: Container(
//               //     height: 47,
//               //     width: double.infinity,
//               //     child: Column(
//               //       mainAxisAlignment: MainAxisAlignment.center,
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         checkoutProvider.setLoaction == null
//               //             ? Text("Set Loaction")
//               //             : Text("Done!"),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 child: ElevatedButton(
//                   style: ButtonStyle(),
//                   onPressed: () {
//                     showDialog(
//                         context: context,
//                         builder: (context) {
//                           return LoadingAlertDialog(
//                               message: 'Uploading.....');
//                         });
//
//                     uploadFile().whenComplete(() {
//                       FirebaseFirestore.instance
//
//                       //working stat
//                       // .collection('FreePost')
//                       // .doc(postID)
//                       //working end
//
//                           .collection('FreePost')
//                           .doc(FirebaseAuth.instance.currentUser?.uid)
//                           .collection('YourPost')
//                           .doc(postID)
//                           .set({
//                         'id': FirebaseAuth.instance.currentUser?.uid,
//                         'userName': name,
//                         'itemTitle': itemTitle,
//                         'postID': postID,
//                         'itemDescription': itemDescription,
//                         'phoneNumber': phoneNumber,
//                         'isAdminApprove': isAdminApprove,
//                         'timestamp': DateTime.now(),
//                         'userImageURl': userImageURl,
//                         'imageUrl1': imageUrlList[0].toString(),
//                         'imageUrl2': imageUrlList[1].toString(),
//                         'imageUrl3': imageUrlList[2].toString(),
//                         'imageUrl4': imageUrlList[3].toString(),
//                         'imageUrl5': imageUrlList[4].toString(),
//                       });
//                       Fluttertoast.showToast(
//                           msg:
//                           'Successfully Added. Wait for admin approval');
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => HomeScreen()));
//                     }).catchError((onError) {
//                       print(onError);
//                     });
//                   },
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : Stack(
//         children: [
//           Container(
//             padding: EdgeInsets.all(4),
//             child: GridView.builder(
//               itemCount: _imagePath.length + 1,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//               ),
//               itemBuilder: (context, index) {
//                 return index == 0
//                     ? Center(
//                   child: IconButton(
//                     icon: Icon(Icons.add_a_photo_outlined),
//                     onPressed: () {
//                       !uploading ? chooseImage() : null;
//                     },
//                   ),
//                 )
//                     : Container(
//                   margin: EdgeInsets.all(3),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                         image: FileImage(_imagePath[index - 1]),
//                         fit: BoxFit.cover),
//                   ),
//                 );
//               },
//             ),
//           ),
//           uploading
//               ? Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Uploading.....',
//                   style: TextStyle(
//                     fontFamily: 'Lobster',
//                     fontSize: 20,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 CircularProgressIndicator(
//                   value: val,
//                   valueColor:
//                   AlwaysStoppedAnimation<Color>(Colors.teal),
//                 ),
//               ],
//             ),
//           )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }
