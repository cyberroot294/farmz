import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_4/models/gallery_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_4/widgets/error_load_data.dart';
import 'package:task_4/widgets/lottie_cow.dart';

import '../constant.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GalleryFuture(),
      lazy: true,
      builder: (context, child) => Scaffold(
        body: FutureBuilder(
          future: Provider.of<GalleryFuture>(context, listen: false)
              .fetchAllGallery(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return LottieCow();
            else if (snapshot.error != null)
              return LottieError();
            else
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: GridView.builder(
                  itemCount:
                      Provider.of<GalleryFuture>(context).listAllGallery.length,
                  itemBuilder: (context, index) {
                    final nDataList = Provider.of<GalleryFuture>(context)
                        .listAllGallery[index];
                    return InkWell(
                      onTap: () => showMaterialModalBottomSheet(
                        context: (context),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                endpointApi + nDataList.img,
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.75,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  nDataList.caption,
                                  // "Lorem oiasdh asidoha saoisdh aihdaio iasidasiodashdoi aisdnasiod asid aisdhaisdhiaos diashdoiashd ",
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                    color: Color(0xFF223322),
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        enableDrag: true,
                        expand: false,
                        duration: Duration(milliseconds: 650),
                        isDismissible: true,
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(endpointApi + nDataList.img),
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
