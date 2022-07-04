import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ppp_news/modelClasses/news_api_entity.dart';

class SingleScreen extends StatelessWidget {
  final NewsApiData newsApiData;

  const SingleScreen({Key? key, required this.newsApiData}) : super(key: key);

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
                    image: NetworkImage("${newsApiData.image}"),
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
                  "${newsApiData.title}",
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
                "${newsApiData.article}",
                style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20.0),
              )),
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "${newsApiData.author}",
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
