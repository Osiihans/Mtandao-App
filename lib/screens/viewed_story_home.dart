import 'package:async/async.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppp_news/modelClasses/drawerItems.dart';
import 'package:ppp_news/modelClasses/news_api_entity.dart';
import 'package:ppp_news/services/stories_api.dart';
import 'package:ppp_news/views/otherStories.dart';
import 'package:ppp_news/views/singleStory.dart';




class ViewScreenHome extends StatefulWidget {
  final String? id;

  const ViewScreenHome({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _ViewScreenHomeState createState() => _ViewScreenHomeState();
}

class _ViewScreenHomeState extends State<ViewScreenHome> {
  //bottomAppBar
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late NewsApiData newsApiData;
  late StoriesApi storiesApi;
  late Future getStories;
  AsyncMemoizer asyncMemoizer = AsyncMemoizer();



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
      getStories = asyncMemoizer.runOnce(() => seeNews());
    });
    //storiesApi = StoriesApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: getStories,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  default:
                    List<NewsApiData>? newData = snapshot.data;
                    if (newData == null) {
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Text("Service currently unavailable"),
                        ),
                      );
                    }
                    NewsApiData? targetStory;
                    List<NewsApiData> otherStories = newData!
                        .where((element) => element.id != widget.id)
                        .toList();
                    print(newData[0].id);
                    print(widget.id);
                    try {
                      targetStory = newData.firstWhere(
                            (element) => element.id == widget.id,
                      );

                      return CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            backgroundColor: primaryDeep.withOpacity(0.9),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            sliver: SliverList(
                                delegate: SliverChildListDelegate(
                                    [SingleScreen(newsApiData: targetStory)])),
                          ),
                          if (otherStories.length > 0)
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
                                                  child: OtherStoryDisplayContainer(
                                                      newsApiData: otherStories[index]),
                                                ),
                                            separatorBuilder:
                                                (BuildContext context, _) => SizedBox(
                                              width: 8,
                                            ),
                                            itemCount: otherStories.length,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                      ],
                                    )
                                  ])),
                            )
                        ],
                      );
                    } on StateError {
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
              }),
        ],
      ),


    );
  }
}
