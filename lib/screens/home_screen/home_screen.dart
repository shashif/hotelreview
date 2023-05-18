import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_review/providers/ads_provider.dart';
import 'package:hotel_review/widgets/color_widget.dart';

import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/homepage_premimum_ads.dart';

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AdsProvider adsProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

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
        actions: [],
      ),
      drawer: DrawerWidget(userProvider: userProvider),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomePagePremiumAds(),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
