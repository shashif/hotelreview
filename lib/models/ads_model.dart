

import 'package:cloud_firestore/cloud_firestore.dart';

class AdsModel {
  String description;
  String phoneNumber;
  String imageURL;
  Timestamp timestamp;


  AdsModel({
    required this.description,
    required this.phoneNumber,
    required this.imageURL,
    required adminProved,
    required this.timestamp,
  });
}
