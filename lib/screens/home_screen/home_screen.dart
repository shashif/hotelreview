import 'package:flutter/material.dart';



import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../widgets/drawer_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {




  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xffd6b738),
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        actions: [

        ],
      ),
      drawer: DrawerWidget(userProvider: userProvider),
      body:Text('This is Home'),
    );
  }
}
