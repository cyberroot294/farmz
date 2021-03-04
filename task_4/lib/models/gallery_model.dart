// To parse this JSON data, do
//
//     final galleryModel = galleryModelFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

List<GalleryModel> galleryModelFromJson(String str) => List<GalleryModel>.from(
    json.decode(str).map((x) => GalleryModel.fromJson(x)));

String galleryModelToJson(List<GalleryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GalleryModel {
  GalleryModel({
    this.id,
    this.img,
    this.caption,
  });

  String id;
  String img;
  String caption;

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
        id: json["id"],
        img: json["img"],
        caption: json["caption"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "caption": caption,
      };
}

class GalleryFuture with ChangeNotifier {
  List<GalleryModel> _listAllGallery = [];

// Getter List Of Gallery
  List<GalleryModel> get listAllGallery {
    return [..._listAllGallery];
  }

  Future<Null> fetchAllGallery() async {
    final responseData = await http.get(endpointApi + "get_gallery.php");
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      final List<GalleryModel> newData = [];
      if (data == null) {
        return;
      }
      for (Map i in data) {
        newData.add(GalleryModel.fromJson(i));
      }

      _listAllGallery = newData;
      notifyListeners();
    }
  }
}
