import 'package:cloud_firestore/cloud_firestore.dart';

class FreePostModel{
  String userName;
  String email;
  String price;
  String itemTitle;
  String postID;
  String itemDescription;
  String phoneNumber;
  String address;
  String userImageURl;
  Timestamp timestamp;
  String? imageUrl1;
  String? imageUrl2;
  String? imageUrl3;
  String? imageUrl4;
  String? imageUrl5;
  // String? imageUrl6;
  // String? imageUrl7;
  // String? imageUrl8;
  // String? imageUrl9;
  // String? imageUrl10;


  FreePostModel({
    required this.userName,
    required this.email,
    required this.price,
    required this.itemTitle,
    required this.postID,
    required this.itemDescription,
    required this.phoneNumber,
    required this.address,
    required this.userImageURl,
    required this.timestamp,
     this.imageUrl1,
     this.imageUrl2,
     this.imageUrl3,
     this.imageUrl4,
     this.imageUrl5,
     // this.imageUrl6,
     // this.imageUrl7,
     // this.imageUrl8,
     // this.imageUrl9,
     // this.imageUrl10,


  });
}

