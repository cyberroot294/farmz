import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_4/models/news_model.dart';
import 'package:task_4/screen/home.dart';
import 'package:task_4/widgets/error_load_data.dart';
import 'package:task_4/widgets/lottie_cow.dart';
import 'package:task_4/widgets/news_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constant.dart';
import 'detail.dart';

class News extends StatelessWidget {
  final _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsFuture>(
      create: (_) => NewsFuture(),
      builder: (context, child) {
        return FutureBuilder(
          future: Provider.of<NewsFuture>(context, listen: false)
              .fetchHeadlineNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LottieCow(
                color: Colors.transparent,
              );
            } else {
              if (snapshot.error != null) {
                return LottieError();
              } else {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Stack(
                        children: [
                          CarouselSlider(
                            carouselController: _controller,
                            items:
                                Provider.of<NewsFuture>(context, listen: true)
                                    .listHeadlineNews
                                    .map(
                                      (news) => CarouselItem(
                                        newsModel: news,
                                      ),
                                    )
                                    .toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: double.maxFinite,
                              autoPlay: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 1800),
                              autoPlayInterval: Duration(milliseconds: 4000),
                              enableInfiniteScroll: true,
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _controller.previousPage(),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _controller.nextPage(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Breaking News",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1,
                                ),
                                MoreButton(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Consumer<NewsFuture>(
                            builder: (context, news, child) {
                              return Container(
                                height: 255,
                                child: ListView.builder(
                                  itemCount: news.listHeadlineNews.length,
                                  itemBuilder: (builder, i) {
                                    final nDataList = news.listHeadlineNews[i];
                                    return NewsCard(
                                      newsModel: nDataList,
                                      width: 240.0,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
          },
        );
      },
      // child:
    );
  }
}

class MoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final home = Provider.of<Home>(context, listen: false);
    return GestureDetector(
      onTap: () {
        home.changeSelectedIndex(1);
      },
      child: Text(
        "More",
        style: Theme.of(context).primaryTextTheme.headline3,
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  final NewsModel newsModel;

  CarouselItem({this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        overflow: Overflow.clip,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  endpointApi + newsModel.img,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0x77AAAAAA),
                  Color(0x77333333),
                ],
                stops: [0.1, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    newsModel.title,
                    style: Theme.of(context).primaryTextTheme.headline2,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 30),
                  child: GestureDetector(
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
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Read More",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle2
                                .copyWith(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    shadows: [
                                      Shadow(
                                        color: Colors.white,
                                        offset: Offset(0, -7),
                                      ),
                                    ],
                                    color: Colors.transparent),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              width: 5,
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
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
