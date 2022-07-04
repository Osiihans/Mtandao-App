import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppp_news/modelClasses/drawerItems.dart';

class  DrawerMenuScreen extends StatefulWidget {
  const  DrawerMenuScreen({Key? key}) : super(key: key);

  @override
  _DrawerMenuScreenState createState() => _DrawerMenuScreenState();
}

class _DrawerMenuScreenState extends State<DrawerMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryDeep,
      padding: EdgeInsets.only(top: 50.0,bottom: 70.0,left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  print("Clicked");
                },
                child: CircleAvatar(
                    child: Icon(Icons.person)
                ),
              ),
              SizedBox(width: 10.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Petro",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  Text("Active Status", style: TextStyle(color: Colors.white),)
                ],
              )
            ],
          ),

          Column(
              children:drawerItems.map((element) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(element['icon'],color: Colors.white,size: 30,),
                    SizedBox(width: 20.0,),
                    GestureDetector(
                        onTap: (){
                          print("Clicked");
                        },
                        child: Text(element['title'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)
                    )
                  ],

                ),
              )).toList()
          ),

          Row(
            children: [
              Icon(Icons.settings,color: Colors.white70,),
              SizedBox(width: 10,),
              Text("Settings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              Container(
                width: 2.0,height: 20,color: Colors.white,
              ),
              SizedBox(width: 10,),
              Text("LogOut",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

            ],
          ),
        ],
      ),

    );
  }
}

