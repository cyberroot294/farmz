// To parse this JSON data, do
//
//     final dictionaryModel = dictionaryModelFromJson(jsonString);

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:task_4/constant.dart';

List<DictionaryModel> dictionaryModelFromJson(String str) =>
    List<DictionaryModel>.from(
        json.decode(str).map((x) => DictionaryModel.fromJson(x)));

String dictionaryModelToJson(List<DictionaryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DictionaryModel {
  DictionaryModel({
    this.id,
    this.namaIstilah,
    this.arti,
    this.penjelasan,
    this.img,
  });

  String id;
  String namaIstilah;
  String arti;
  String penjelasan;
  String img;

  DictionaryModel copyWith({
    String id,
    String namaIstilah,
    String arti,
    String penjelasan,
    String img,
  }) =>
      DictionaryModel(
        id: id ?? this.id,
        namaIstilah: namaIstilah ?? this.namaIstilah,
        arti: arti ?? this.arti,
        penjelasan: penjelasan ?? this.penjelasan,
        img: img ?? this.img,
      );

  factory DictionaryModel.fromJson(Map<String, dynamic> json) =>
      DictionaryModel(
        id: json["id"],
        namaIstilah: json["nama_istilah"],
        arti: json["arti"],
        penjelasan: json["penjelasan"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_istilah": namaIstilah,
        "arti": arti,
        "penjelasan": penjelasan,
        "img": img,
      };
}

class DictionaryFuture extends ChangeNotifier {
  List<DictionaryModel> _listAllDictionary = [];

  String _searchString = "";

  UnmodifiableListView<DictionaryModel> get allDictionary =>
      _searchString.isEmpty
          ? UnmodifiableListView(_listAllDictionary)
          : UnmodifiableListView(
              _listAllDictionary.where((dict) => dict.namaIstilah
                  .toLowerCase()
                  .contains(_searchString.toLowerCase())),
            );

  void changeSearchString(String searchString) {
    _searchString = searchString;
    print(_searchString);
    notifyListeners();
  }

  Future<Null> fetchAllDict() async {
    final responseData = await http.get(endpointApi + "get_dictionary.php");
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      final List<DictionaryModel> newData = [];
      if (data == null) {
        return;
      }
      for (Map i in data) {
        newData.add(DictionaryModel.fromJson(i));
      }

      _listAllDictionary = newData;
      notifyListeners();
    }
  }
}
