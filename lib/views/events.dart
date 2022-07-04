import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppp_news/modelClasses/events_news_entity.dart';

class EventScreen extends StatelessWidget {
  final EventsNewsData eventsNewsData;
  final String? id;

  const EventScreen({Key? key,required this.eventsNewsData,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0,),
          AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              height: MediaQuery.of(context).size.height - 300,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${eventsNewsData.image}"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Column(
              children: [
                Container(
                  child: Text(
                    "${eventsNewsData.title}",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    child: Text(
                      "${eventsNewsData.article}",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20.0),
                    )),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "${eventsNewsData.author}",
                    style: TextStyle(color: Colors.pinkAccent),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
