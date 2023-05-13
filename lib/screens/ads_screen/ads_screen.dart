import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotel_review/providers/ads_provider.dart';
import 'package:hotel_review/widgets/global_var.dart';
import 'package:hotel_review/widgets/rounded_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/color_widget.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  File? imagePath;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userBannerAdsURL = '';
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    // _cropImage(pickedFile!.path);
    print('Image file Location 1:--- ${pickedFile?.path}');
    print('Image file Location 2:--- ${imagePath?.path}');
    setState(() {
      imagePath = File(pickedFile!.path);
    });

    final User? user = _auth.currentUser;
    uid = user!.uid;
    final ref = FirebaseStorage.instance
        .ref()
        .child('BannerAdsbyUserStorage')
        .child(uid + uniqueFileName + '.jpg');

    await ref.putFile(imagePath!);
    userBannerAdsURL = await ref.getDownloadURL();

    print('userBannerAdsURL: ${userBannerAdsURL}');
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        imagePath = File(croppedImage!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AdsProvider adsProvider = Provider.of(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Ads Screen',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FancyShimmerImage(
                    width: double.infinity,
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/hotelreview-81f23.appspot.com/o/ads.jpg?alt=media&token=09ef1540-8c44-47e7-8b58-446a964f7832'),
              ),

              SizedBox(
                height: 5,
              ),

              CircleAvatar(
                backgroundColor: primaryColor,
                radius: screenWidth * 0.1,
                child: IconButton(
                    onPressed: () {
                      _getFromGallery();
                    },
                    color: Colors.white,
                    icon: Icon(
                      Icons.add_a_photo_outlined,
                    )),
              ),
              // InkWell(
              //   child: CircleAvatar(radius:screenWidth* 0.20 ,
              //   backgroundColor: Colors.white24,
              //
              //   ),
              //   onTap: (){},
              // ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: adsProvider.descriptionEditingController,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Mobile:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: adsProvider.phoneEditingController,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    adsProvider.photoController.text = userBannerAdsURL;
                  });
                  adsProvider.validator(context);
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
