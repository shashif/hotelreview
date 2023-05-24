import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_review/models/free_post_model.dart';
import 'package:uuid/uuid.dart';

import '../screens/home_screen/home_screen.dart';

class FreePostProvider with ChangeNotifier{
  bool isAdminApprove = false;
  String postID = Uuid().v4();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController itemTitleController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController userImageURlController = TextEditingController();
  TextEditingController imageUrl1Controller = TextEditingController();
  TextEditingController imageUrl2Controller = TextEditingController();
  TextEditingController imageUrl3Controller = TextEditingController();
  TextEditingController imageUrl4Controller = TextEditingController();
  TextEditingController imageUrl5Controller = TextEditingController();
  TextEditingController imageUrl6Controller = TextEditingController();
  TextEditingController imageUrl7Controller = TextEditingController();
  TextEditingController imageUrl8Controller = TextEditingController();
  TextEditingController imageUrl9Controller = TextEditingController();
  TextEditingController imageUrl10Controller = TextEditingController();

  late FreePostModel freePostModel;

  NewModel(QueryDocumentSnapshot element) {
    freePostModel = FreePostModel(
      userName: element.get("userName"),
      email: element.get("email"),
      price: element.get("price"),
      itemTitle: element.get("itemTitle"),
      postID: element.get("postID"),
      itemDescription: element.get("itemDescription"),
      phoneNumber: element.get("phoneNumber"),
      address: element.get("address"),
      userImageURl: element.get("userImageURl"),
      timestamp: element.get("timestamp"),
      imageUrl1: element.get("imageUrl1"),
      imageUrl2: element.get("imageUrl2"),
      imageUrl3: element.get("imageUrl3"),
      imageUrl4: element.get("imageUrl4"),
      imageUrl5: element.get("imageUrl5"),
      // imageUrl6: element.get("imageUrl6"),
      // imageUrl7: element.get("imageUrl7"),
      // imageUrl8: element.get("imageUrl8"),
      // imageUrl9: element.get("imageUrl9"),
      // imageUrl10: element.get("imageUrl10"),
    );
  }


  void validator(context) async {
    if (itemTitleController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Title is empty");
    } else if (itemDescriptionController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Details is empty");
    }
    else if (phoneNumberController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Mobile Number is empty");
    }
    else if (addressController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Address is empty");
    }


    else {
      notifyListeners();
      await FirebaseFirestore.instance
          .collection('FreePost')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('YourPost')
          .doc(postID)
          .set({
        'id': FirebaseAuth.instance.currentUser?.uid,
        'userName': userNameController.text,
        'itemTitle': itemTitleController.text,
        'postID': postID,
        'itemDescription': itemDescriptionController.text,
        'phoneNumber': phoneNumberController.text,
        'isAdminApprove': isAdminApprove,
        'timestamp': DateTime.now(),
        'userImageURl': userImageURlController.text,
        'imageUrl1': imageUrl1Controller.text,
        'imageUrl2': imageUrl2Controller.text,
        'imageUrl3': imageUrl3Controller.text,
        'imageUrl4': imageUrl4Controller.text,
        'imageUrl5': imageUrl5Controller.text,
        // 'imageUrl6': imageUrl6Controller.text,
        // 'imageUrl7': imageUrl7Controller.text,
        // 'imageUrl8': imageUrl8Controller.text,
        // 'imageUrl9': imageUrl9Controller.text,
        // 'imageUrl10': imageUrl10Controller.text,
      }).then((value) async {

        notifyListeners();
        await Fluttertoast.showToast(msg: "Please call for admin approval");



        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        notifyListeners();
      });
      notifyListeners();
    }
  }



}