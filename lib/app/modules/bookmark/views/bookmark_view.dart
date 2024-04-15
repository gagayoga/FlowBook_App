import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // size
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light, // Change this color as needed
    ));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light, // Change this color as needed
    ));

    return Scaffold(
        body: Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/splash/bg_flowbook.png'),
        fit: BoxFit.cover,
      )),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 140,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: kontenKoleksiBuku(),
                ),
                SizedBox(
                  height: height * 0.020,
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black,
              width: width,
              height: 100,
              child: Padding(
                padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Koleksi Buku Anda',
                            style: GoogleFonts.averiaGruesaLibre(
                              fontSize: 22,
                              color: const Color(0xFF008A93),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Kumpulan dataKoleksi koleksi Anda.',
                            style: GoogleFonts.averiaGruesaLibre(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        await controller.getData();
                      },
                      child: GestureDetector(
                        onTap: () async {
                          await controller.getData();
                        },
                        child: const Icon(
                          CupertinoIcons.refresh_circled_solid,
                          color: Color(0xFF008A93),
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget kontenKoleksiBuku() {
    const Color background = Color(0xFF008A93);
    const Color borderColor = Color(0xFF424242);

    // size
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    return SizedBox(
      child: Obx(
        () {
          if (controller.koleksiBook.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: borderColor.withOpacity(0.30),
                        width: 0.3,
                      )),
                  child: Center(
                    child: Text(
                      'Bookmark empty',
                      style: GoogleFonts.averiaGruesaLibre(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.koleksiBook.length,
              itemBuilder: (context, index) {
                var dataKoleksi = controller.koleksiBook[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.DETAILBOOK,
                        parameters: {
                          'id': (dataKoleksi.bukuID ?? 0).toString(),
                          'judul': (dataKoleksi.judul!).toString()
                        },
                      );
                    },
                    child: SizedBox(
                      width: width,
                      height: 225,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: width,
                          height: 225,
                          child: Stack(
                            clipBehavior: Clip.antiAlias,
                            children: [
                              Positioned(
                                top: 22.5,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 180,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.43, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dataKoleksi.judul!,
                                                maxLines: 2,
                                                style: GoogleFonts
                                                    .averiaGruesaLibre(
                                                  fontWeight: FontWeight.w900,
                                                  color:
                                                      const Color(0xFF008A93),
                                                  fontSize: 30.0,
                                                ),
                                                textAlign: TextAlign.start,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              SizedBox(
                                                height: height * 0.010,
                                              ),

                                              Text(
                                                dataKoleksi.deskripsi!,
                                                style: GoogleFonts
                                                    .averiaGruesaLibre(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              SizedBox(
                                                height: height * 0.010,
                                              ),

                                              dataKoleksi.rating != null &&
                                                      dataKoleksi.rating! > 0
                                                  ? RatingBarIndicator(
                                                      rating:
                                                          dataKoleksi.rating!,
                                                      direction:
                                                          Axis.horizontal,
                                                      itemCount: 5,
                                                      itemSize: 15,
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                    )
                                                  : RatingBarIndicator(
                                                      rating: 5,
                                                      direction:
                                                          Axis.horizontal,
                                                      itemCount: 5,
                                                      itemSize: 15,
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                child: Container(
                                  height: 225,
                                  width: 155,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0,
                                            -3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      dataKoleksi.coverBuku.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
