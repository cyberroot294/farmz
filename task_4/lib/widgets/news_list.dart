import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_4/models/news_model.dart';

class NewsList extends StatelessWidget {
  final NewsModel newsModel;
  final DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
  final description;
  final img;
  NewsList({@required this.newsModel, this.description, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              image: DecorationImage(
                scale: 0.5,
                image: NetworkImage(
                  "https://task4udacodingnabiel.nasiwebhost.com/" +
                      newsModel.img,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 130,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.57,
                  child: Text(
                    newsModel.title,
                    style: Theme.of(context).primaryTextTheme.headline3,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  // width: 200,
                  width: MediaQuery.of(context).size.width * 0.57,
                  child: Text(
                    newsModel.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style:
                        Theme.of(context).primaryTextTheme.subtitle2.copyWith(
                              color: Color(0xFF161616),
                              fontSize: 12,
                            ),
                  ),
                ),
                Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateFormat.format(newsModel.createdAt),
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                      ),
                      Text(
                        newsModel.author,
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                // Text(
                // "Biden terpilih menjadi presiden setelah mengalahkan lawannya yaitu si Donald Bebek Alias si Donald Trump Si Tua Bangka",
                // overflow: TextOverflow.ellipsis,
                // maxLines: 3,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
