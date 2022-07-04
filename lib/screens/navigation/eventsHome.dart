import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppp_news/modelClasses/drawerItems.dart';
import 'package:ppp_news/modelClasses/events_news_entity.dart';
import 'package:ppp_news/screens/viewStory.dart';
import 'package:ppp_news/services/stories_api.dart';
import 'package:ppp_news/views/events.dart';
import 'package:ppp_news/views/otherEvents.dart';

import '../storyScreen.dart';

class HomeEvents extends StatefulWidget {
  final EventsNewsData? eventsNewsData;
  final String? id;
  const HomeEvents({Key? key,this.eventsNewsData,this.id}) : super(key: key);

  @override
  _HomeEventsState createState() => _HomeEventsState();
}

class _HomeEventsState extends State<HomeEvents> with SingleTickerProviderStateMixin {

  AsyncMemoizer asyncMemoizer = AsyncMemoizer();
  late StoriesApi storiesApi;
  late Future getEvents;
  List<EventsNewsData> events = [];

  Future<List<EventsNewsData?>?> EventsSee() async {
    Response response;
    try {
      response = await Dio().get("http://triplep.tv/api/stories.php");
      print(response.statusCode);
      print(response.data["data"].runtimeType);
      if (response.statusCode == 200) {
        print(response.statusCode);
        List data = response.data["data"];
        return data.map((e) => EventsNewsData.fromJson(e)).toList();
      }
      return null;
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getEvents = asyncMemoizer.runOnce(() =>   EventsSee() );
    });
    storiesApi = StoriesApi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryDeep, primaryDeep.withOpacity(0.9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.8])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child:Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ViewScreen(),
                        ));
                  },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    )
                ),
                SizedBox(height: 10,),
                Text("Events",
                textAlign: TextAlign.left, style: TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 44,
                    color:const Color(0xffffffff),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                /*DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        "WHAT'S ON",
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 20,
                          color: Colors.pink,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Image.asset('images/drop_down_icon.png'),
                  ),
                  underline: SizedBox(), onChanged: (value) {  },
                ),*/
                FutureBuilder(
                  future: getEvents,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if (snapshot.hasError) {
                        return Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Text("Service currently unavailable"),
                          ),
                        );
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      }
                      switch (snapshot.connectionState){
                        case ConnectionState.waiting:
                          return Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        default:
                          List<EventsNewsData>? eventsData = snapshot.data;
                          if (eventsData == null) {
                            Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Text("Service currently unavailable"),
                              ),
                            );
                          }
                          EventsNewsData? targetEvent;
                          List<EventsNewsData> otherEvents = eventsData!
                              .where((element) => element.id != widget.id)
                              .toList();
                          print(eventsData[0].id);
                          print(widget.id);
                          try{

                            targetEvent = eventsData.firstWhere(
                                  (element) => element.id == widget.id,
                            );

                            return Expanded(
                              child: CustomScrollView(
                                slivers: [
                                  SliverAppBar(
                                    backgroundColor: primaryDeep.withOpacity(0.9),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.all(8.0),
                                    sliver: SliverList(
                                        delegate: SliverChildListDelegate(
                                            [EventScreen(eventsNewsData: targetEvent)])),
                                  ),
                                  if (otherEvents.length > 0)
                                    SliverPadding(
                                      padding: const EdgeInsets.all(8.0),
                                      sliver: SliverList(
                                          delegate: SliverChildListDelegate([
                                            Column(
                                              children: [
                                                SizedBox(height: 15.0,),
                                                Container(
                                                  height: 190.0,
                                                  child: ListView.separated(
                                                    itemBuilder:
                                                        (BuildContext context, int index) =>
                                                        Center(
                                                          child: OtherEventsScreen(
                                                              eventsNewsData: otherEvents[index]),
                                                        ),
                                                    separatorBuilder:
                                                        (BuildContext context, _) => SizedBox(
                                                      width: 8,
                                                    ),
                                                    itemCount: otherEvents.length,
                                                    scrollDirection: Axis.horizontal,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ])),
                                    )
                                ],
                              ),
                            );

                          } on StateError{
                            return CustomScrollView(
                              slivers: [
                                SliverAppBar(
                                  backgroundColor: primaryDeep.withOpacity(0.9),
                                ),
                                SliverPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  sliver: SliverList(
                                      delegate: SliverChildListDelegate([
                                        Container(
                                          height: MediaQuery.of(context).size.height / 2,
                                          child: Text("Story not found"),
                                        )
                                      ])),
                                ),
                              ],
                            );
                          }



                      }



                    })
              ],
            ),
          ),

        ),
      ),

    );
  }
}
