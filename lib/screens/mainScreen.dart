import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppp_news/screens/storyScreen.dart';

import 'navigation/drawerMenu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String idScreen = "mainScreen";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: const [
          DrawerMenuScreen(),
          StoryScreen()

        ],
      ),
    );
  }
}
