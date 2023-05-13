import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_review/providers/ads_provider.dart';
import 'package:hotel_review/providers/user_provider.dart';
import 'package:hotel_review/screens/splash_screen/splash_screen.dart';
import 'package:hotel_review/widgets/color_widget.dart';
import 'package:provider/provider.dart';

import 'auth/sing_in.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[

        ChangeNotifierProvider<UserProvider>(create: (context)=>UserProvider(),),
        ChangeNotifierProvider<AdsProvider>(create: (context)=>AdsProvider(),),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
        ),
        // home: HomeScreen(),
        home: SplashScreen(),
      )
      ,
    );
  }
}
