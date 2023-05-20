import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../widgets/color_widget.dart';
import '../../widgets/drawer_widget.dart';
class SearchProduct extends StatefulWidget {

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    var userData= userProvider.currentUserData;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontFamily:'Lobster',
          ),
        ),
      ),
      drawer: DrawerWidget(userProvider: userProvider),

    );
  }
}
