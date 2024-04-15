import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_detail_buku.dart';
import '../controllers/detailbook_controller.dart';

class DetailbookView extends GetView<DetailbookController> {
  const DetailbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 55;

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
          Get.parameters['judul'].toString(),
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
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash/bg_flowbook.png'),
                fit: BoxFit.cover,
              )
          ),
          width: width,
          height: bodyHeight,
          child: Stack(
            children: [
              ListView(
                children: [
                  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: sectionDetailBook()
                  ),
                  const SizedBox(height: 80),
                ],
              ),

              Positioned(
                bottom: 100,
                right: 30,
                child: floatingButton(),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black,
                  child: Obx((){
                    var dataBuku = controller.dataDetailBook.value?.buku;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: SizedBox(
                          height: 50.0,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: dataBuku?.statusPeminjaman == 'Belum dipinjam' ? const Color(0xFF008A93) : Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          100))),
                              onPressed: () {
                                if (dataBuku?.statusPeminjaman == 'Belum dipinjam') {
                                  controller.showConfirmPeminjaman(() => Navigator.pop(Get.context!, 'OK'), 'Lanjutkan');
                                }else if(dataBuku?.statusPeminjaman == 'Dipinjam'){
                                  return;
                                }
                              },
                              child: Text(
                                dataBuku?.statusPeminjaman == 'Belum dipinjam'
                                    ? 'Pinjam Buku' : 'Dipinjam',
                                style: GoogleFonts.averiaGruesaLibre(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: dataBuku?.statusPeminjaman == 'Belum dipinjam'
                                        ? Colors.white :const Color(0xFF008A93)),
                              )
                          )
                      ),
                    );
                  })
                ),
              )
            ],
          ),
        )
    );
  }

  Widget sectionDetailBook(){
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    final bodyHeight = height - 50;
    return Obx((){
      if (controller.dataDetailBook.isNull) {
        return SizedBox(
          width: width,
          height: bodyHeight,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF008A93)),
            ),
          ),
        );
      } else if (controller.dataDetailBook.value == null) {
        return SizedBox(
          width: width,
          height: bodyHeight,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF008A93)),
            ),
          ),
        );
      } else {
        var dataBuku = controller.dataDetailBook.value?.buku;
        var dataUlasan = controller.dataDetailBook.value?.ulasan;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50)
                ),
              ),

              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.025,
                  ),

                  SizedBox(
                    width: width,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: width,
                        height: 250,
                        child: Stack(
                          clipBehavior: Clip.antiAlias,
                          children: [

                            Positioned(
                              top: 35,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                height: 180,
                                child: Padding(
                                  padding: EdgeInsets.only(left: width * 0.43, right: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dataBuku!.judul!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.averiaGruesaLibre(
                                                fontWeight: FontWeight.w900,
                                                color: const Color(0xFF008A93),
                                                fontSize: 30.0,
                                              ),
                                              textAlign: TextAlign.start,
                                              softWrap: true,
                                            ),

                                            SizedBox(
                                              height: height * 0.010,
                                            ),

                                            Text(
                                              dataBuku.deskripsi!,
                                              style: GoogleFonts.averiaGruesaLibre(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 12.0,
                                              ),
                                              maxLines: 3,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                            SizedBox(
                                              height: height * 0.010,
                                            ),

                                            RatingBarIndicator(
                                              rating: dataBuku.rating!,
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              itemSize: 20,
                                              itemBuilder: (context, _) => const Icon(
                                                Icons.star,
                                                color: Colors.amber,
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
                                height: 250,
                                width: width * 0.40,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, -3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    dataBuku.coverBuku.toString(),
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

                  SizedBox(
                    height: height * 0.030,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Pengarang: ${dataBuku.penulis} | Penerbit: ${dataBuku.penerbit} | Tahun Terbit: ${dataBuku.tahunTerbit}'
                          ' | Jumlah Halaman: ${dataBuku.jumlahHalaman.toString()} | Jumlah Peminjam: ${dataBuku.jumlahPeminjam.toString()}',
                      style: GoogleFonts.averiaGruesaLibre(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.3,
                        height: 1.6,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: 5,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Tentang buku ini',
                      style: GoogleFonts.averiaGruesaLibre(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                        height: 1.6,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      dataBuku.deskripsi!.toString(),
                      style: GoogleFonts.averiaGruesaLibre(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.3,
                        height: 1.6,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: height * 0.030,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Penilaian dan Ulasan',
                          style: GoogleFonts.averiaGruesaLibre(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                            height: 1.6,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: buildUlasanList(dataUlasan),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: height * 0.020,
            ),


          ],
        );
      }
    }
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF424242).withOpacity(0.10),
                  width: 0.5,
                )
            ),
            width: width,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/foto_profile.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: width * 0.025,
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ulasan.users?.username ?? '',
                                    style: GoogleFonts.averiaGruesaLibre(
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF008A93),
                                        fontSize: 14),
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                    ulasan.ulasan!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.averiaGruesaLibre(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFB9B6B6),
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            // Menampilkan rating di bawah teks penulis
                            SizedBox(
                              child: RatingBarIndicator(
                                direction: Axis.horizontal,
                                rating: ulasan.rating!.toDouble(),
                                itemCount: 5,
                                itemSize: 14,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Color(0xFF008A93),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242).withOpacity(0.01),
          width: 0.5,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.averiaGruesaLibre(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget floatingButton(){
    const Color colorActive = Color(0xFF008A93);

    return Obx(() {
          var dataBuku = controller.dataDetailBook.value?.buku;
          return Positioned(
            bottom: 100,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                if (dataBuku?.status == "Tersimpan") {
                  controller.deleteKoleksiBook(dataBuku!.bukuID.toString(), Get.context!);
                } else {
                  controller.addKoleksiBuku(Get.context!);
                }
              },
              backgroundColor: dataBuku?.status == "Tersimpan"
                  ? Colors.white
                  : colorActive,
              child: FaIcon(
                dataBuku?.status == "Tersimpan"
                    ? CupertinoIcons.bookmark_fill
                    : Icons.bookmark_add_rounded,
                color: dataBuku?.status == "Tersimpan" ? colorActive : Colors
                    .white,
                size: 28,
              ),
            ),
          );
        }
    );
  }
}
