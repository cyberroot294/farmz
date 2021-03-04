import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:task_4/models/dict_model.dart';
import 'package:task_4/widgets/error_load_data.dart';
import 'package:task_4/widgets/lottie_cow.dart';

import 'detail.dart';

class Dictionary extends StatefulWidget {
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<DictionaryFuture>(
        create: (_) => DictionaryFuture(),
        builder: (context, child) => FutureBuilder(
          future: Provider.of<DictionaryFuture>(context, listen: false)
              .fetchAllDict(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? LottieCow()
              : snapshot.hasError
                  ? LottieError()
                  : Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            color: Color(0xFFD4334C),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: TextFormField(
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Cari berdasarkan nama penyakit",
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey[600], fontSize: 12),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                onChanged: (value) {
                                  Provider.of<DictionaryFuture>(context,
                                          listen: false)
                                      .changeSearchString(value);
                                },
                                controller: this.searchController,
                              ),
                            ),
                          ),
                        ),
                        displayDictionary(context),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget displayDictionary(BuildContext context) {
    return Consumer<DictionaryFuture>(
      builder: (context, dict, child) {
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            children: dict.allDictionary
                .map(
                  (i) => ListDictionary(
                    dict: i,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class ListDictionary extends StatelessWidget {
  final DictionaryModel dict;

  ListDictionary({@required this.dict});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
            .copyWith(left: 20),
        onTap: () {
          showMaterialModalBottomSheet(
            elevation: 10,
            enableDrag: true,
            duration: Duration(milliseconds: 450),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            context: context,
            builder: (context) {
              return Detail(
                img: dict.img,
                penjelasan: dict.penjelasan,
                title: dict.namaIstilah,
              );
            },
          );
        },
        title: Text(
          dict.namaIstilah,
          style: GoogleFonts.montserrat(
            color: Color(0xFF223344),
          ),
          softWrap: true,
        ),
        subtitle: Text(dict.arti),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
