import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reyhan_flowbook/app/data/provider/storage_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final appbar = MediaQuery.of(context).padding.top;

    double bodyHeight = height - appbar;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,// Change this color as needed
    ));

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: bodyHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash/bg_flowbook.png'),
                fit: BoxFit.cover,
              )
          ),
          child: RefreshIndicator(
            onRefresh: () async{
              await controller.getData();
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: width,
                      height: height * 0.26,
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)
                          )
                        ),
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: topHeader(),
                        ),
                      )
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AutoSizeText(
                            "Buku TerPopular",
                            minFontSize: 15,
                            maxLines: 1,
                            maxFontSize: 25,
                            style: GoogleFonts.averiaGruesaLibre(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 25.0,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Obx(() => controller.popularBooks.isEmpty ?
                            shimmerkontenBukuPopular() : kontenBukuPopular()
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rekomendasi Buku",
                          maxLines: 1,
                          style: GoogleFonts.averiaGruesaLibre(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 25.0,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Obx(() => controller.newBooks.isEmpty ?
                        shimmerKontenBukuTerbaru() : kontenBukuTerbaru()
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: height * 0.020,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topHeader(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: AutoSizeText.rich(
            TextSpan(
              text: "Selamat Datang ",
              style: GoogleFonts.averiaGruesaLibre(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.white, // Color for the fixed text
              ),
              children: [
                TextSpan(
                  text: StorageProvider.read(StorageKey.username),
                  style: GoogleFonts.averiaGruesaLibre(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: const Color(0xFF008A93), // Color for the username
                  ),
                ),
              ],
            ),
          ),
        ),

        FittedBox(
          child: AutoSizeText(
            'Hari ini apa yang mau anda baca?',
            textAlign: TextAlign.start,
            style: GoogleFonts.averiaGruesaLibre(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            minFontSize: 12.0,
            maxFontSize: 18.0,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: AnimatedTextField(
            //controller: controller.emailController,
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                ),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20.20)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20.20)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(20.20)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20.20)),
                hintText: 'Search Book',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                hintStyle: GoogleFonts.averiaGruesaLibre(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(0.50),
                )),
            hintTexts: const [
              'Search for "Rekommended Book"',
              'Search for "Borrow Book"',
              'Search for "All Book"',
            ],
          ),
        ),
      ],
    );
  }

  Widget kontenBukuPopular(){
    return SizedBox(
      height: 250,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.popularBooks.length,
          itemBuilder: (context, index) {
            var buku = controller.popularBooks[index];
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.DETAILBOOK,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 20 : 0,
                  right: index < controller.popularBooks.length - 1 ? 10 : 20,
                ),
                child: Container(
                  width: 135,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF6F6F6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 135,
                        height: 175,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: 4 / 5,
                            child: Image.network(
                              buku.coverBuku.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  buku.judul!,
                                  style: GoogleFonts.averiaGruesaLibre(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF008A93),
                                      fontSize: 18.0
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              FittedBox(
                                child: Text(
                                  "Penulis : ${buku.penulis!}",
                                  maxLines: 1,
                                  style: GoogleFonts.averiaGruesaLibre(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 10.0
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 2),
                              FittedBox(
                                child: Text(
                                  "Tahun ${buku.tahunTerbit!}",
                                  style: GoogleFonts.averiaGruesaLibre(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 14.0
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget shimmerkontenBukuPopular(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: 250,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 20 : 0,
                  right: index < controller.popularBooks.length - 1 ? 10 : 10,
                ),
                child: Container(
                  width: 135,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF6F6F6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 135,
                        height: 175,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 5),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 12,
                                color: Colors.white,
                              ),

                              const SizedBox(
                                height: 3,
                              ),

                              Container(
                                width: double.infinity,
                                height: 12,
                                color: Colors.white,
                              ),

                              const SizedBox(
                                height: 3,
                              ),

                              Container(
                                width: double.infinity,
                                height: 12,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget kontenBukuTerbaru() {
    final width = MediaQuery.of(Get.context!).size.width;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.newBooks.length,
      itemBuilder: (context, index) {
        var buku = controller.newBooks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.DETAILBOOK,
                parameters: {
                  'id': (buku.bukuID ?? 0).toString(),
                  'judul': (buku.judulBuku!).toString()
                },
              );
            },
            child: Container(
              width: width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF6F6F6).withOpacity(0.70),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width : 150,
                    height: 200,
                    child: ClipRRect(
                      borderRadius : BorderRadius.circular(10),
                      child: Image.network(
                        buku.coverBuku.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            buku.judulBuku!,
                            style: GoogleFonts.averiaGruesaLibre(
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF008A93),
                              fontSize: 24.0,
                            ),
                            textAlign: TextAlign.start,
                          ),

                          const SizedBox(height: 3),
                          Text(
                            buku.deskripsi!,
                            maxLines : 3,
                            style: GoogleFonts.averiaGruesaLibre(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16.0,
                                letterSpacing: -0.3
                            ),
                            textAlign: TextAlign.justify,
                          ),

                          const SizedBox(height: 5),
                          FittedBox(
                            child: Text(
                              "Penulis: ${buku.penulisBuku!}",
                              maxLines : 1,
                              style: GoogleFonts.averiaGruesaLibre(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 3),
                          FittedBox(
                            child: Text(
                              "${ buku.jumlahHalaman!} Halaman",
                              maxLines : 1,
                              style: GoogleFonts.averiaGruesaLibre(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget shimmerKontenBukuTerbaru(){
    final width = MediaQuery.of(Get.context!).size.width;

    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF6F6F6).withOpacity(0.70),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width : 150,
                    height: 200,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 16,
                            color: Colors.white,
                          ),

                          const SizedBox(
                            height: 3,
                          ),

                          Container(
                            width: double.infinity,
                            height: 20,
                            color: Colors.white,
                          ),

                          const SizedBox(
                            height: 3,
                          ),

                          Container(
                            width: double.infinity,
                            height: 12,
                            color: Colors.white,
                          ),
                          
                          const SizedBox(
                            height: 3,
                          ),

                          Container(
                            width: double.infinity,
                            height: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
