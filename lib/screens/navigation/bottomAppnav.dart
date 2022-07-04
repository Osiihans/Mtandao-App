import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class BottomApp_nav extends StatefulWidget {
  const BottomApp_nav({Key? key}) : super(key: key);

  @override
  _BottomApp_navState createState() => _BottomApp_navState();
}

class _BottomApp_navState extends State<BottomApp_nav> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 47,
        items: [
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index){
          setState(() {

          });
        },
      )
    );
  }
}
