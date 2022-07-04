import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ppp_news/modelClasses/drawerItems.dart';
import 'package:ppp_news/modelClasses/news_api_entity.dart';
import 'package:ppp_news/screens/viewStory.dart';

class MainStory extends StatelessWidget {
  final bool isEven;
  final NewsApiData? newsApiData;

  const MainStory({Key? key, required this.isEven, this.newsApiData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewScreen(
                id: this.newsApiData!.id,
              ),
            ));
      },
      child: Container(
        child: isEven
            ? Container(
                height: 240.0,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 60.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //boxShadow: shadowList,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.values.last,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${newsApiData!.title}")),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              child: Text("${newsApiData!.author}",
                                  style: TextStyle(color: Colors.pinkAccent)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: primaryDeep.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                            //boxShadow: shadowList,
                          ),
                        ),
                        Align(
                            child: Image.network(
                          "${newsApiData!.image}",
                        ) //// Please check hero widget
                        ),
                      ],
                    )),
                  ],
                ),
              )
            : Container(
                height: 240.0,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: primaryDeep.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                            //boxShadow: shadowList,
                          ),
                        ),
                        Align(
                            child: Image.network(
                                "${newsApiData!.image}") // Please check hero widget
                            ),
                      ],
                    )),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 60.0, bottom: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //boxShadow: shadowList,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.values.last,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  "${newsApiData!.title}",
                                  style: TextStyle(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Text(
                              "${newsApiData!.author}",
                              style: TextStyle(color: Colors.pinkAccent),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
