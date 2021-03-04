import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

List<NewsModel> newsFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel with ChangeNotifier {
  NewsModel({
    this.id,
    this.title,
    this.description,
    this.img,
    this.author,
    this.createdAt,
  });

  String id;
  String title;
  String description;
  String img;
  String author;
  DateTime createdAt;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        img: json["img"],
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "img": img,
        "author": author,
        "created_at": createdAt.toIso8601String(),
      };
}

class NewsFuture with ChangeNotifier {
  List<NewsModel> _listAllNews = [];
  List<NewsModel> _listHeadlineNews = [];

// Getter List Of News
  List<NewsModel> get listAllNews {
    return [..._listAllNews];
  }

  List<NewsModel> get listHeadlineNews {
    return [..._listHeadlineNews];
  }

  Future<Null> fetchAllNews() async {
    final responseData = await http.get(endpointApi + "get_berita.php");
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      final List<NewsModel> newData = [];

      // if (data == null) {
      //   return;
      // }

      for (Map i in data) {
        newData.add(NewsModel.fromJson(i));
      }

      _listAllNews = newData;
      notifyListeners();
    }
  }

  Future<Null> fetchHeadlineNews() async {
    final responseData = await http.get(endpointApi + "get_headline_news.php");
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      final List<NewsModel> newData = [];

      // if (data == null) {
      //   return;
      // }

      for (Map i in data) {
        newData.add(NewsModel.fromJson(i));
      }

      _listHeadlineNews = newData;
      notifyListeners();
    }
  }
}
