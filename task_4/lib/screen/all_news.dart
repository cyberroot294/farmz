import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_4/models/news_model.dart';
import 'package:task_4/widgets/error_load_data.dart';
import 'package:task_4/widgets/lottie_cow.dart';
import 'package:task_4/widgets/news_list.dart';
import 'detail.dart';

class AllNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsFuture>(
      create: (_) => NewsFuture(),
      lazy: true,
      builder: (context, child) => Scaffold(
        body: FutureBuilder(
          future:
              Provider.of<NewsFuture>(context, listen: false).fetchAllNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LottieCow(
                color: Colors.transparent,
              );
            } else {
              if (snapshot.hasError) {
                return LottieError();
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: ListView(
                      children: Provider.of<NewsFuture>(context)
                          .listAllNews
                          .map((news) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(
                              newsModel: news,
                            ),
                          ),
                        );
                      },
                      child: NewsList(
                        newsModel: news,
                      ),
                    );
                  }).toList()),
                );
              }
            }
          },
        ),
      ),
      // child: ,
    );
  }
}
