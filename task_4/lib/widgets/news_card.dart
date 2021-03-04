import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_4/models/news_model.dart';
import 'package:task_4/screen/detail.dart';

class NewsCard extends StatelessWidget {
  final double width;
  final double imgHeight;
  final double imgWidth;
  final DateFormat dateFormat = new DateFormat('dd MMMM yyyy');
  final NewsModel newsModel;

  NewsCard(
      {this.width, this.imgHeight, this.imgWidth, @required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: this.width,
      // height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(
                    newsModel: this.newsModel,
                  ),
                ),
              );
            },
            child: Wrap(
              children: [
                Container(
                  height: 150,
                  // height: this.imgHeight,
                  width: 240,
                  // width: this.imgWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://task4udacodingnabiel.nasiwebhost.com/" +
                            newsModel.img,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      // bottomLeft: Radius.circular(50),
                      // bottomRight: Radius.circular(50),
                      Radius.circular(15),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    newsModel.title,
                    style: Theme.of(context).primaryTextTheme.headline6,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dateFormat.format(newsModel.createdAt),
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "By " + newsModel.author,
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
