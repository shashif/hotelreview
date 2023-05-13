import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/home_screen/home_screen.dart';

class AdsProvider with ChangeNotifier {
  bool isloadding = false;
  bool isAdminApprove = false;

  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController photoController = TextEditingController();



  void validator(context) async {
    if (descriptionEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Description is empty");
    } else if (phoneEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number is empty");
    }



    else {
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("HomeBannerAdsByUser")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('YourAds')
          .doc()
          .set({
        "description": descriptionEditingController.text,
        "phoneNumber": phoneEditingController.text,
        "imageURL":photoController.text ,
        "adminProved": isAdminApprove,
        "PostdateAndTime": DateTime.now(),
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Please call for admin approval");

        descriptionEditingController.clear();
        phoneEditingController.clear();

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        notifyListeners();
      });
      notifyListeners();
    }
  }
}
