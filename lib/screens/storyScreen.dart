import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ppp_news/modelClasses/drawerItems.dart';
import 'package:ppp_news/modelClasses/news_api_entity.dart';
import 'package:ppp_news/screens/navigation/eventsHome.dart';
import 'package:ppp_news/services/stories_api.dart';
import 'package:ppp_news/views/mainStory.dart';




class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);
  static const String idScreen = "storyScreen";


  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  List<NewsApiData> content = [];
  AsyncMemoizer asyncMemoizer = AsyncMemoizer();
  late NewsApiData newsApiData;
  late StoriesApi storiesApi;
  late Future getStories;

  Future<List<NewsApiData?>?> seeNews() async {
    Response response;
    try {
      response = await Dio().get("http://triplep.tv/api/stories.php");
      print(response.statusCode);
      print(response.data["data"].runtimeType);
      if (response.statusCode == 200) {
        print(response.statusCode);
        List data = response.data["data"];
        return data.map((e) => NewsApiData.fromJson(e)).toList();
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
      getStories = asyncMemoizer.runOnce(() =>  seeNews() );
    });
    storiesApi = StoriesApi();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)..rotateY(isDrawerOpen? -0.5: 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius:BorderRadius.circular(isDrawerOpen ? 40.0 : 0.0)),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isDrawerOpen
                        ? IconButton(
                        onPressed: (){
                          setState(() {
                            xOffset=0;
                            yOffset=0;
                            scaleFactor=1;
                            isDrawerOpen=false;

                          });
                        },
                        icon: Icon(Icons.arrow_back))
                        : IconButton(
                        onPressed: () {
                          setState(() {
                            xOffset = 230;
                            yOffset = 150;
                            scaleFactor = 0.6;
                            isDrawerOpen=true;
                          });
                        },
                        icon: Icon(Icons.menu)),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Hi Petro"),
                            SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: Image(
                                image: AssetImage("images/triplep.png"),),
                            )
                          ],
                        )
                      ],
                    ),
                    CircleAvatar(child: IconButton( icon: Icon(Icons.calendar_today_sharp), onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeEvents()) );
                    },)
                    )
                  ],
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  margin:
                  EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.search),
                      //change search
                      Text("Search story"),
                      //Account Settings
                      Icon(Icons.settings),
                    ],
                  ),
                ),
                Container(
                  height: 120.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: drawerItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 5, right: 5.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  //boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  drawerItems[index]["icon"],
                                  color: Colors.blueGrey[400],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, bottom: 20.0, top: 20.0),
                              child: Center(
                                  widthFactor: 2.0,
                                  child: Text(drawerItems[index]["title"])),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: getStories,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return  SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Text("Service currently unavailable"),
                        )
                      ]));
                } else if (!snapshot.hasData) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      ]));
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        ]));
                  default:
                    List<NewsApiData?>? newData = snapshot.data;
                    if (newData == null) {
                      SliverList(
                          delegate: SliverChildListDelegate([
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Text("Service currently unavailable"),
                            )
                          ]));
                    }
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return MainStory(
                                  isEven: (index + 1) % 2 == 0, newsApiData: newData![index]);
                            }, childCount: newData!.length));
                }
              }),
        ],
      ),

    );
  }
}