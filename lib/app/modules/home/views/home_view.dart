import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reyhan_flowbook/app/data/provider/storage_provider.dart';
import 'package:reyhan_flowbook/components/customListBukuRekomendasi.dart';
import 'package:reyhan_flowbook/components/customPopulerBuku.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final appbar = MediaQuery.of(context).padding.top;

    double bodyHeight = height - appbar;

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
          child: SingleChildScrollView(
            child: Column(
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

                rekomendasiBuku(),

                populerBuku(),

              ],
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
        AutoSizeText.rich(
          TextSpan(
            text: "Selamat Datang ",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 25,
              color: Colors.white, // Color for the fixed text
            ),
            children: [
              TextSpan(
                text: StorageProvider.read(StorageKey.username),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: const Color(0xFF008A93), // Color for the username
                ),
              ),
            ],
          ),
        ),

        AutoSizeText(
          'Hari ini apa yang mau anda baca?',
          textAlign: TextAlign.start,
          style: GoogleFonts.inter(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          minFontSize: 12.0,
          maxFontSize: 20.0,
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

  Widget rekomendasiBuku(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: AutoSizeText(
              'Rekomendasi Buku',
              maxFontSize: 35,
            minFontSize: 25,
            maxLines: 1,
              style: GoogleFonts.abhayaLibre(
                fontWeight: FontWeight.w900,
                color: Colors.black,
                fontSize: 28.0
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: CustomListRekomendasiBuku(
                context: Get.context!
            ),
          ),
        ],
      ),
    );
  }

  Widget populerBuku(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            'Buku Populer',
            maxFontSize: 35,
            minFontSize: 25,
            maxLines: 1,
            style: GoogleFonts.abhayaLibre(
                fontWeight: FontWeight.w900,
                color: Colors.black,
                fontSize: 28.0
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: CustomPopulerBuku(
                context: Get.context!
            ),
          ),
        ],
      ),
    );
  }
}
