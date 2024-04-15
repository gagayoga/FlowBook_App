import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookbykategori_controller.dart';

class BookbykategoriView extends GetView<BookbykategoriController> {
  const BookbykategoriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    const Color background = Colors.black;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: background,
      statusBarIconBrightness: Brightness.light, // Change this color as needed
    ));
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        toolbarHeight: 55,
        title: Text(
          'Kategori Buku ${Get.parameters['namaKategori'].toString()}',
          style: GoogleFonts.averiaGruesaLibre(
              fontSize: 20.0,
              color: const Color(0xFF008A93),
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: kontenSemuaBuku(),
          ),
        ),
      )
    );
  }

  Widget kontenSemuaBuku(){
    return Obx((){
      if (controller.dataBookByKategori.isEmpty) {
        return kontenDataKosong(Get.parameters['namaKategori'].toString());
      }else{
        return GridView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 4 / 7.5,
          ),
          itemCount: controller.dataBookByKategori.length,
          itemBuilder: (context, index) {
            var buku = controller.dataBookByKategori[index];
            return InkWell(
              onTap: (){
                Get.toNamed(Routes.DETAILBOOK,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF5F5F5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(
                        aspectRatio: 4 / 5,
                        child: Image.network(
                          buku.coverBuku.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            buku.judul!,
                            style: GoogleFonts.averiaGruesaLibre(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF008A93),
                                fontSize: 18.0
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 4),

                          FittedBox(
                            child: Text(
                              "Penulis : ${buku.penulis!}",
                              style: GoogleFonts.averiaGruesaLibre(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 10.0
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // Menampilkan rating di bawah teks penulis
                          buku.rating != null && buku.rating! > 0
                              ? RatingBarIndicator(
                            direction: Axis.horizontal,
                            rating: buku.rating!,
                            itemCount: 5,
                            itemSize: 15,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color(0xFF008A93),
                            ),
                          )
                              : RatingBarIndicator(
                            direction: Axis.horizontal,
                            rating: buku.rating!,
                            itemCount: 5,
                            itemSize: 15,
                            itemBuilder: (context, _) => const Icon(
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
            );
          },
        );
      }
    }
    );
  }

  Widget kontenDataKosong(String text) {
    const Color background = Color(0xFF008A93);
    const Color borderColor = Color(0xFF424242);
    return Center(
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor.withOpacity(0.20),
              width: 0.3,
            )),
        child: Center(
          child: Text(
            'Sorry Data $text Empty!',
            style: GoogleFonts.averiaGruesaLibre(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
