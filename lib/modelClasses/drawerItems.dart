import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = Color(0xff416d6d);
Color primaryDeep = Color(0xff011e30);
Color primaryTextColor = Color(0xFF414C6B);
Color secondaryTextColor = Color(0xFFE4979E);
Color titleTextColor = Colors.white;
Color contentTextColor = Color(0xff868686);
Color navigationColor = Color(0xFF6751B5);
Color gradientStartColor = Color(0xFF0050AC);
Color gradientEndColor = Color(0xFF9354B9);

List<BoxShadow> shadowList = [
  BoxShadow(color: Color.fromRGBO(244, 244, 244, 1),blurRadius: 30,offset: Offset(0,10))
];

List<Map> drawerItems = [
  {
    "icon": FontAwesomeIcons.briefcase,
    "title" :'Active Bids'
  },
  {
    'icon': FontAwesomeIcons.download,
    'title' :'Work History'
  },
  {
    'icon': Icons.monetization_on,
    'title' :'Earnings'
  },
  {
    'icon': Icons.favorite,
    'title' :'Favorites'
  },
  {
    'icon': Icons.message,
    'title' :'Messages'
  },
];