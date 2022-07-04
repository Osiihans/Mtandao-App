import 'package:flutter/cupertino.dart';

class LiveShowScreen extends StatefulWidget {
  const LiveShowScreen({Key? key}) : super(key: key);

  @override
  _LiveShowScreenState createState() => _LiveShowScreenState();
}

class _LiveShowScreenState extends State<LiveShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: [
           Center(
             child: Container(
               child: Center(child: Image.asset("images/jalash.jpg")),
             ),
           )

         ],
       ),
    );
  }
}
