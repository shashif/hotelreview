// import 'dart:io';
//
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hotel_review/providers/free_post_provider.dart';
//
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
// import '../dialogbox/loading_dialog.dart';
// import '../google_map/google_map.dart';
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
//   chooseImage() async {
//     if (_imagePath.length >= 10) {
//       Fluttertoast.showToast(
//         msg: 'Maximum limit of 10 images reached',
//         gravity: ToastGravity.CENTER,
//       );
//       return;
//     }
//
//     XFile? pickedFile =
//     await ImagePicker().pickImage(source: ImageSource.gallery);
//     setState(() {
//       _imagePath.add(File(pickedFile!.path));
//     });
//   }
//
//   // chooseImage() async {
//   //   XFile? pickedFile =
//   //   await ImagePicker().pickImage(source: ImageSource.gallery);
//   //   setState(() {
//   //     _imagePath.add(File(pickedFile!.path));
//   //   });
//   // }
//
//   // Future uploadFile() async {
//   //   int i = 1;
//   //   for (var img in _imagePath) {
//   //     setState(() {
//   //       val = i / _imagePath.length;
//   //     });
//   //
//   //     String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//   //     String fileExtension = Path.extension(img.path);
//   //     String fileName =
//   //         '${Path.basenameWithoutExtension(img.path)}$uniqueFileName$fileExtension';
//   //
//   //     var ref = FirebaseStorage.instance
//   //         .ref()
//   //     // .child('freePostImage/${Path.basename(img.path)}');
//   //         .child('FreePostImage/$fileName');
//   //     await ref.putFile(img).whenComplete(() async {
//   //       await ref.getDownloadURL().then((value) {
//   //         imageUrlList.add(value);
//   //         i++;
//   //       });
//   //     });
//   //   }
//   // }
//
//   Future uploadFile() async {
//     int i = 1;
//     int totalImages = _imagePath.length;
//     int remainingImages = 10 - totalImages;
//
//     for (var img in _imagePath) {
//       setState(() {
//         val = i / totalImages;
//       });
//
//       String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//       String fileExtension = Path.extension(img.path);
//       String fileName =
//           '${Path.basenameWithoutExtension(img.path)}$uniqueFileName$fileExtension';
//
//       var ref = FirebaseStorage.instance
//           .ref()
//           .child('FreePostImage/$fileName');
//
//       await ref.putFile(img).whenComplete(() async {
//         await ref.getDownloadURL().then((value) {
//           imageUrlList.add(value);
//           i++;
//         });
//       });
//     }
//
//     // Append empty strings to maintain the length of 10 elements
//     for (int j = 0; j < remainingImages; j++) {
//       imageUrlList.add('');
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     UserProvider userProvider = Provider.of(context);
//     userProvider.getUserData();
//     // var userData = userProvider.currentUserData;
//     name = widget.userData.userName;
//     emailID = widget.userData.userEmail;
//     userImageURl = widget.userData.userImage;
//
//     FreePostProvider freePostProvider = Provider.of(context);
//
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
//                   uploadFile();
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
//                 controller: freePostProvider.priceController,
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: 'Enter Title'),
//                 controller: freePostProvider.itemTitleController,
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: 'Write details'),
//                 keyboardType: TextInputType.multiline,
//                 maxLines: 5,
//                 controller: freePostProvider.itemDescriptionController,
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//                 controller: freePostProvider.phoneNumberController,
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: 'Address'),
//                 controller: freePostProvider.addressController,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: 3,
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => CostomGoogleMap(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   height: 47,
//                   width: double.infinity,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       freePostProvider.setLoaction == null
//                           ? Text("Set Loaction")
//                           : Text("Done!"),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 child: ElevatedButton(
//                   style: ButtonStyle(),
//                   onPressed: () {
//                     // showDialog(
//                     //     context: context,
//                     //     builder: (context) {
//                     //       return LoadingAlertDialog(
//                     //           message: 'Uploading.....');
//                     //     });
//
//                     setState(() {
//                       freePostProvider.userImageURlController.text =
//                           userImageURl;
//                       freePostProvider.userNameController.text = name;
//                       freePostProvider.emailController.text = emailID;
//                       freePostProvider.imageUrl1Controller.text =
//                           imageUrlList[0].toString();
//                       freePostProvider.imageUrl2Controller.text =
//                           imageUrlList[1].toString();
//                       freePostProvider.imageUrl3Controller.text =
//                           imageUrlList[2].toString();
//                       freePostProvider.imageUrl4Controller.text =
//                           imageUrlList[3].toString();
//                       freePostProvider.imageUrl5Controller.text =
//                           imageUrlList[4].toString();
//                       freePostProvider.imageUrl6Controller.text =
//                           imageUrlList[5].toString();
//                       freePostProvider.imageUrl7Controller.text =
//                           imageUrlList[6].toString();
//                       freePostProvider.imageUrl8Controller.text =
//                           imageUrlList[7].toString();
//                       freePostProvider.imageUrl9Controller.text =
//                           imageUrlList[8].toString();
//                       freePostProvider.imageUrl10Controller.text =
//                           imageUrlList[9].toString();
//                     });
//
//
//                     // uploadFile().whenComplete(() {
//                     //   freePostProvider.validator(context);
//                     // }).catchError((onError) {
//                     //   print(onError);
//                     // });
//
//                     freePostProvider.validator(context);
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
