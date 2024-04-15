import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/historypeminjaman_controller.dart';

class HistorypeminjamanView extends GetView<HistorypeminjamanController> {
  const HistorypeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // size
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
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
                      child: kontenHistoryPeminjaman(),
                    ),
                    SizedBox(
                      height: height * 0.020,
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.black,
                  width: width,
                  height: 100,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'History Peminjaman Buku',
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
                                  'Kumpulan data history peminjaman Anda.',
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
                              await controller.getDataPeminjaman();
                            },
                            child: GestureDetector(
                              onTap: () async {
                                await controller.getDataPeminjaman();
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
                ),
              )
            ],
          ),
        ));
  }

  Widget kontenHistoryPeminjaman() {
    const Color background = Color(0xFF008A93);
    const Color borderColor = Color(0xFF424242);

    // size
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    return SizedBox(
      child: Obx(
            () {
          if (controller.historyPeminjaman.isEmpty) {
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
                      'History Peminjaman empty',
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
              itemCount: controller.historyPeminjaman.length,
              itemBuilder: (context, index) {
                var dataHistory = controller.historyPeminjaman[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      dataHistory.status == 'Selesai' ? controller.kontenBeriUlasan(dataHistory.bukuId.toString(), dataHistory.judulBuku.toString()) :
                      Get.toNamed(Routes.BUKTIPEMINJAMAN, parameters: {
                        'idPeminjaman': dataHistory.peminjamanID.toString(),
                        'asalHalaman' : 'historyPeminjaman',
                      });
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
                                                dataHistory.kodePeminjaman!,
                                                style: GoogleFonts
                                                    .averiaGruesaLibre(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                  fontSize: 24.0,
                                                ),
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              SizedBox(
                                                height: height * 0.010,
                                              ),

                                              Text(
                                                dataHistory.judulBuku!,
                                                maxLines: 2,
                                                style: GoogleFonts
                                                    .averiaGruesaLibre(
                                                  fontWeight: FontWeight.w900,
                                                  color:
                                                  const Color(0xFF008A93),
                                                  fontSize: 20.0,
                                                ),
                                                textAlign: TextAlign.start,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              SizedBox(
                                                height: height * 0.010,
                                              ),

                                              Text(
                                                'Tanggal Pinjam : ${dataHistory.tanggalPinjam!}',
                                                style: GoogleFonts
                                                    .averiaGruesaLibre(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                ),
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              SizedBox(
                                                height: height * 0.010,
                                              ),

                                              Text(
                                                'Tanggal Deadline : ${dataHistory.deadline!}',
                                                style: GoogleFonts
                                                    .averiaGruesaLibre(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                ),
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
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
                                  width: 150,
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
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          dataHistory.coverBuku.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      Positioned(
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: dataHistory.status == 'Ditolak'
                                                  ? const Color(0xFFEA1818)
                                                  : dataHistory.status == 'Dipinjam'
                                                  ? const Color(0xFF56526F)
                                                  : dataHistory.status ==
                                                  'Selesai'
                                                  ? const Color(0xFF008A93)
                                                  : const Color(0xFF1B1B1D),
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10),
                                              )),
                                          child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  dataHistory.status == 'Selesai' ? const SizedBox() : const FaIcon(
                                                    FontAwesomeIcons.circleInfo,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),


                                                  dataHistory.status == 'Selesai' ? const SizedBox() : const SizedBox(
                                                    width: 10,
                                                  ),

                                                  Text(
                                                    dataHistory.status == 'Selesai' ? 'Beri Ulasan' : dataHistory.status.toString(),
                                                    style: GoogleFonts.averiaGruesaLibre(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ],
                                              )),
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
