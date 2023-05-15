import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_review/widgets/global_var.dart';

import '../models/ads_model.dart';
import '../screens/home_screen/home_screen.dart';

class AdsProvider with ChangeNotifier {
  bool isloadding = false;
  bool isAdminApprove = false;

  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  late AdsModel adsModel;


  //List<AdsModel>searchLlist=[];
  adsNewModel(QueryDocumentSnapshot element) {
    adsModel = AdsModel(
      timestamp: element.get("timestamp"),
      adminProved: element.get("adminProved"),
      description: element.get("description"),
      imageURL: element.get("imageURL"),
      phoneNumber: element.get("phoneNumber"),

    );

    //searchLlist.add(adsModel);
  }

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
          .collection('YourPremiumAds')
          .doc()
          .set({
        "description": descriptionEditingController.text,
        "phoneNumber": phoneEditingController.text,
        "imageURL":photoController.text ,
        "adminProved": isAdminApprove,
        "timestamp": DateTime.now(),
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


  /////////////////////////////Premium Ads data for all user start//////////////////////
  List<AdsModel> premiumAdsList = [];

  fetchPremiumAdsData() async {
    List<AdsModel> newList = [];

    QuerySnapshot querySnapshotValue =
    await FirebaseFirestore.instance
        .collectionGroup("YourPremiumAds")
        //.orderBy('timestamp', descending: true)
        // .where("adminProved", isEqualTo: false)
        .get();

    querySnapshotValue.docs.forEach((element) {
      adsNewModel(element);
      newList.add(adsModel);
    });

    premiumAdsList = newList;
    notifyListeners();
  }

  List<AdsModel> get getfetchpremiumAdsDataList {
    return premiumAdsList;
  }

/////////////////////////////Premium Ads data for all user end//////////////////////


/////////////////////////////Premium Ads data start//////////////////////
  List<AdsModel> premiumAdsCurrentUserList = [];

  fetchPremiumAdsCurrentData() async {
    List<AdsModel>? newList = [];
    QuerySnapshot querySnapshotValue =
    await FirebaseFirestore.instance
        .collection("HomeBannerAdsByUser")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourAds')
        .get();

    querySnapshotValue.docs.forEach((element) {
      print(element.data());

      adsNewModel(element);

      newList.add(adsModel);
    });

    premiumAdsCurrentUserList = newList;
    notifyListeners();
  }

  List<AdsModel> get getfetchpremiumAdsCurrentUserDataList {
    return premiumAdsCurrentUserList;
  }

/////////////////////////////Premium Ads data end//////////////////////


}
