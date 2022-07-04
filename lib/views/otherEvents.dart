import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppp_news/modelClasses/events_news_entity.dart';
import 'package:ppp_news/screens/navigation/eventsHome.dart';


class OtherEventsScreen extends StatelessWidget {
  final String? id;
  const OtherEventsScreen({Key? key,required this.eventsNewsData,this.id}) : super(key: key);
  final EventsNewsData eventsNewsData;
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 3/2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>HomeEvents(
                              id: this.eventsNewsData.id,
                            ),
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("${eventsNewsData.image}"),
                          fit: BoxFit.cover,),borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 150.0,
            left: 5,
            child: Container(
              width: 250.0,
              height: 30.0,
              child: Text(
                "${eventsNewsData.title}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Opensans",
                  color: Colors.white,
                ),

              ),

            ),
          ),
        ],

      ),
    );
  }
}
