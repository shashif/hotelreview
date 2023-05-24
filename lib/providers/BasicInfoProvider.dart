import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../models/basic_info_model.dart';

class BasicInfoProvider with ChangeNotifier {
  late BasicInfoModel basicInfoModel;

  NewModel(QueryDocumentSnapshot element) {
    basicInfoModel = BasicInfoModel(
      appsTitle: element.get("appsTitle"),
      appsDescription: element.get("appsDescription"),
    );
  }



/////////////////////////addBasicAppInfo start////////////////////////////
  void addBasicAppInfo() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Get a reference to the collection
    CollectionReference appInfoCollection =
    FirebaseFirestore.instance.collection("AppsBasicInformation");

    // Check if the document already exists
    QuerySnapshot querySnapshot = await appInfoCollection.limit(1).get();
    if (querySnapshot.docs.isEmpty) {
      // Document does not exist, perform the set operation
      await appInfoCollection.doc().set({
        "appsTitle": "Hotel & Resort Review & Offer",
        "appsDescription": "Booking your desired Hotel and Resort",
      });

      print('Basic app information inserted successfully!');
    } else {
      // Document already exists
      print('Basic app information already exists!');
    }
  }
/////////////////////////addBasicAppInfo End////////////////////////////

/////////////////////////readBasicAppInfo Start////////////////////////

  List<BasicInfoModel> basicInfoDataList = [];

  readBasicAppInfo() async {
    List<BasicInfoModel>? newList = [];
    QuerySnapshot querySnapshotValue =
    await FirebaseFirestore.instance
        .collection("AppsBasicInformation")
        .get();

    querySnapshotValue.docs.forEach((element) {
      print(element.data());

      NewModel(element);

      newList.add(basicInfoModel);
    });

    basicInfoDataList = newList;
    notifyListeners();

    // if (basicInfoDataList.isNotEmpty) {
    //   // Set the value of "title" to the first element's "appsTitle" value
    //    basicInfoDataList[0].appsTitle;
    // }
  }

  List<BasicInfoModel> get getReadBasicAppInfoDataList {
    return basicInfoDataList;
  }

/////////////////////////readBasicAppInfo End////////////////////////

}
