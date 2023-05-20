import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_review/widgets/global_var.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../widgets/color_widget.dart';
import '../../widgets/drawer_widget.dart';

class UploadAddScreen extends StatefulWidget {
  UserModel userData;

  UploadAddScreen({required this.userData});

  @override
  State<UploadAddScreen> createState() => _UploadAddScreenState();
}

class _UploadAddScreenState extends State<UploadAddScreen> {
  bool next = false;
  bool uploading = false;
  final List<File> _imagePath = [];

  List<String> imageUrlList = [];

  // widget.userData.userName
  String name = '';
  String emailID = '';
  double val = 0;
  CollectionReference? imgRef;

  String itemPrice = '';
  String itemModel = '';
  String itemColor = '';
  String itemDescription = '';

  chooseImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imagePath.add(File(pickedFile!.path));
    });
  }

  Future upload() async {
    int i = 1;
    for (var img in _imagePath) {
      setState(() {
        val = i / _imagePath.length;
      });

      var ref = FirebaseStorage.instance
          .ref()
          .child('freePostImage/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imageUrlList.add(value);
          i++;
        });
      });
    }
  }

  getNameOFUser() {
    // FirebaseFirestore.instance
    //     .collection('usersData')
    //     .doc(uid)
    //     .get()
    //     .then((value) async {
    //   if (value.exists) {
    //     setState(() {
    //       // name = value.data()!['userName'];
    //       // emailID = value.data()!['userEmail'];
    //
    //
    //     });
    //   }
    // });
    // name = widget.userData.userName;
    // emailID = widget.userData.userEmail;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getNameOFUser();
    imgRef = FirebaseFirestore.instance.collection('imageUrls');
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    var userData = userProvider.currentUserData;
    name = widget.userData.userName;
    emailID = widget.userData.userEmail;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(
          next ? 'Please write Post details' : 'Choose the item images',
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontFamily: 'Lobster',
          ),
        ),
        actions: [
          next
              ? Container()
              : ElevatedButton(
                  onPressed: () {
                    if ( _imagePath.length >0) {
                      setState(() {
                        uploading = true;
                        next = true;
                      });
                    }
                    else{
                      Fluttertoast.showToast(msg: 'Please Select minimum 1 picture',
                      gravity: ToastGravity.CENTER);
                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: "Verela",
                      fontSize: 25,
                    ),
                  )),
        ],
      ),
      drawer: DrawerWidget(userProvider: userProvider),
      body: next
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Enter  Price'),
                      onChanged: (value) {
                        itemPrice = value;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Enter Name'),
                      onChanged: (value) {
                        itemModel = value;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Write details'),
                      onChanged: (value) {
                        itemDescription = value;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Color'),
                      onChanged: (value) {
                        itemColor = value;
                      },
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  child: GridView.builder(
                    itemCount: _imagePath.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: IconButton(
                                icon: Icon(Icons.add_a_photo_outlined),
                                onPressed: () {
                                  !uploading ? chooseImage() : null;
                                },
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: FileImage(_imagePath[index - 1]),
                                    fit: BoxFit.cover),
                              ),
                            );
                    },
                  ),
                ),
                uploading
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Uploading.....',
                              style: TextStyle(
                                fontFamily: 'Lobster',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CircularProgressIndicator(
                              value: val,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.teal),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
