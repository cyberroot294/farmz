import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_4/models/news_model.dart';
import 'package:task_4/constant.dart';

class Detail extends StatelessWidget {
  final img;
  final title;
  final penjelasan;

  final NewsModel newsModel;
  Detail({this.newsModel, this.img, this.penjelasan, this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        panel: Container(
          height: double.infinity,
          child: ListView.builder(
            itemCount: 1,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30)
                .copyWith(bottom: 200),
            itemBuilder: (context, index) => newsBody(),
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        minHeight: MediaQuery.of(context).size.height * 0.65,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        body: Container(
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        endpointApi + "/" + (newsModel?.img ?? this.img),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0x55000000),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      this.newsModel?.title ?? this.title,
                      maxLines: 5,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline2
                          .copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListBody newsBody() {
    return ListBody(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            this.newsModel?.title ?? this.title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          child: Text(
            this.newsModel?.description ?? this.penjelasan,
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
