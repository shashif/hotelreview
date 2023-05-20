import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_review/providers/ads_provider.dart';
import 'package:hotel_review/widgets/color_widget.dart';

import 'package:provider/provider.dart';

import '../../providers/BasicInfoProvider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/homepage_premimum_ads.dart';
import '../profile_screen/profile_screen.dart';
import '../search_product/search_product.dart';
import '../splash_screen/splash_screen.dart';
import '../upload_add_screen/upload_add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AdsProvider initadsProvider = Provider.of(context, listen: false);
    initadsProvider.fetchPremiumAdsData();
    // initadsProvider.fetchPremiumAdsCurrentData();

    BasicInfoProvider basicInfoProvider = Provider.of(context, listen: false);
    basicInfoProvider.addBasicAppInfo();
    basicInfoProvider.readBasicAppInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AdsProvider adsProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    var userData= userProvider.currentUserData;


    BasicInfoProvider basicInfoProvider=Provider.of(context);
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
        title:  const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily:'Lobster',
          ),
        ),
        actions: [

          TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  ProfileScreen(userData:userData)));
          }, child: Icon(Icons.person_outline,color: Colors.black54,)),
          TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  SearchProduct()));
          }, child: Icon(Icons.search_outlined,color: Colors.black54,)),
          TextButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SplashScreen()));
          }, child: Icon(Icons.login_outlined,color: Colors.black54,)),


        ],
      ),
      drawer: DrawerWidget(userProvider: userProvider),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Post',
        child: Icon(Icons.cloud_upload),
        backgroundColor: primaryColor,
        onPressed: (){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => UploadAddScreen(userData:userData)));
        },

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomePagePremiumAds(),
                // Row(
                //   children: basicInfoProvider.getReadBasicAppInfoDataList.map(
                //         (value) {
                //       return  Container(
                //           width: 170,
                //           padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                //           margin:
                //           EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             color: Colors.white,
                //
                //           ),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //
                //              Text(value.appsTitle),
                //              SizedBox(height: 3,),
                //              Text(value.appsDescription),
                //             ],
                //           ),
                //
                //       );
                //
                //     },
                //   ).toList(),
                // )





              ],
            ),
          ),
        ),
      ),
    );
  }
}
