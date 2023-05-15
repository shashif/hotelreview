import 'package:flutter/material.dart';
import 'package:hotel_review/screens/ads_screen/ads_screen.dart';

import '../providers/user_provider.dart';
import '../screens/home_screen/home_screen.dart';
import 'drawer_list_tile_widget.dart';


class DrawerWidget extends StatefulWidget {
  DrawerWidget({required this.userProvider});

  UserProvider userProvider;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var userData= widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        color: const Color(0xffd1ad17),
        child: ListView(
          children: [
            DrawerHeader(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
              children: [
                   CircleAvatar(
                    backgroundColor: Colors.white54,
                    radius: 43,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.yellow,
                      backgroundImage: NetworkImage(userData.userImage ?? ""),
                    ),
                  ),
                   SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(userData.userName),
                       Text(userData.userEmail,overflow: TextOverflow.ellipsis,),
                       SizedBox(height: 7,),

                    ],
                  ),
              ],
            ),
                )),
            listTile(
                iconData: Icons.home_outlined,
                title: "Home",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                }),
            listTile(
                iconData: Icons.shop_outlined,
                title: "Premium Ads Post",
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AdsScreen()));
                }),
            listTile(
                iconData: Icons.person_outlined,
                title: "My Profile",
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) =>  MyProfile(userData:userData)));
                }),
            listTile(
                iconData: Icons.notifications_outlined,
                title: "Notification",
                onTap: () {}),
            listTile(
                iconData: Icons.star_outlined,
                title: "Rating and Review",
                onTap: () {}),
            listTile(
                iconData: Icons.favorite_outlined,
                title: "Wishlist",
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => WishListScreen()));
                }),
            listTile(
                iconData: Icons.copy_outlined,
                title: "Raise & Complaint",
                onTap: () {}),
            listTile(
                iconData: Icons.format_quote_outlined,
                title: "FAQs",
                onTap: () {}),
            Container(
              height: 350,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Contact Support'),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Text('Call us:'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('+8801611500060'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Text('Mail us:'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('shoriful.hasan@gmail.com'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
