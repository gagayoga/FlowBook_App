import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  const ExplorerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Size
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash/bg_flowbook.png'),
              fit: BoxFit.cover,
            )
        ),
        child: RefreshIndicator(
          onRefresh: () async{
            await controller.getDataBook();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: kontenSearch(),
                ),

                kontenLayoutSearch(),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget kontenLayoutSearch(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: sectionKategoriBuku(),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: kontenSemuaBuku(),
        )
      ],
    );
  }

  Widget kontenSearch(){
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: AnimatedTextField(
        controller: controller.searchController,
        onChanged: (value){
          controller.getDataBook();
        },
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
              fontWeight: FontWeight.w900,
              color: Colors.black.withOpacity(0.50),
            )),
        hintTexts: const [
          'Search for "Rekommended Book"',
          'Search for "Borrow Book"',
          'Search for "All Book"',
        ],
      ),
    );
  }

  Widget sectionKategoriBuku(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return SizedBox(
              height: MediaQuery.of(Get.context!).size.height * 0.050,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.dataKategori.length,
                  itemBuilder: (context, index) {
                    var buku = controller.dataKategori[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 20 : 0,
                        right: index < controller.dataKategori.length - 1 ? 5 : 20,
                      ),
                      child: SizedBox(
                        child: TextButton(
                            onPressed: (){
                              Get.toNamed(Routes.BOOKBYKATEGORI,
                                parameters: {
                                  'idKategori': (buku.kategoriID ?? 0).toString(),
                                  'namaKategori': (buku.namaKategori!).toString()
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.black.withOpacity(0.95),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                buku.namaKategori!,
                                style: GoogleFonts.alegreya(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            )
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          ),
        ],
      ),
    );
  }

  Widget kontenSemuaBuku(){
    return Obx((){
      if (controller.dataAllBook.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF008A93)),
          ),
        );
      }else{
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 4 / 7.5,
          ),
          itemCount: controller.dataAllBook.length,
          itemBuilder: (context, index) {
            var buku = controller.dataAllBook[index];
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

  Widget kontenSearchBook(double width, double height) {
    String text = controller.searchController.text.toString();

    if (controller.searchBook.isEmpty) {
      return kontenDataKosong(text);
    } else {
      return SizedBox(
        height: height,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 5 / 8,
          ),
          itemCount: controller.searchBook.length,
          itemBuilder: (context, index) {
            var buku = controller.searchBook[index];
            return InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.DETAILBOOK,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF6F6F6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 175,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AspectRatio(
                          aspectRatio: 5 / 6,
                          child: Image.network(
                            buku.coverBuku.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
        ),
      );
    }
  }
}
