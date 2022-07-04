import 'package:flutter/material.dart';
import 'package:ppp_news/authify/authifyScreen.dart';
import 'package:ppp_news/authify/onBoarding.dart';
import 'package:ppp_news/screens/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainScreen.idScreen,
      routes: {
        OnBoardingScreen.idScreen:(context) => OnBoardingScreen(),
        AuthScreen.idScreen:(context) => AuthScreen(),
        MainScreen.idScreen:(context) => MainScreen(),
      },

    );
  }
}
