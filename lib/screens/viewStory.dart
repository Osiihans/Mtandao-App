import 'package:async/async.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppp_news/modelClasses/news_api_entity.dart';
import 'package:ppp_news/screens/messages_screen.dart';
import 'package:ppp_news/screens/user_profile.dart';
import 'package:ppp_news/screens/viewed_story_home.dart';
import 'package:ppp_news/services/stories_api.dart';

class ViewScreen extends StatefulWidget {
  final String? id;

  const ViewScreen({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  //bottomAppBar
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late NewsApiData newsApiData;
  late StoriesApi storiesApi;
  late Future getStories;
  AsyncMemoizer asyncMemoizer = AsyncMemoizer();

  //BottomAppBar
  int selectedIndex = 0;

  final PageStorageBucket _bucket = PageStorageBucket();

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
      currentPage = pages[index];
    });
  }

  Widget? currentPage;

  List<Widget> pages = [];

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
      pages = [
        ViewScreenHome(
          id: widget.id,
          key: PageStorageKey("VIEW_SCREEN_HOME"),
        ),
        MessageScreen(
          key: PageStorageKey("MESSAGE_SCREEN"),
        ),
        ProfileScreen(
          key: PageStorageKey("PROFILE_SCREEN"),
        )
      ];
      currentPage = pages[0];
    });
    //storiesApi = StoriesApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: currentPage!,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        unselectedItemColor: Colors.black54,
        onTap: changePage,
        currentIndex: selectedIndex,
      ),
    );
  }
}
