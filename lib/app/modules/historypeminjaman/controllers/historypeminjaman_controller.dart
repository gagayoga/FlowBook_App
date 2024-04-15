import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/customTextField.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/model/peminjaman/response_history_peminjaman.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class HistorypeminjamanController extends GetxController with StateMixin{

  var historyPeminjaman = RxList<DataHistory>();
  String idUser = StorageProvider.read(StorageKey.idUser);

  // Post Ulasan
  double ratingBuku= 0;
  final loadingUlasan = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController ulasanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataPeminjaman();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataPeminjaman() async {
    change(null, status: RxStatus.loading());

    try {
      final responseHistoryPeminjaman = await ApiProvider.instance().get(
          '${Endpoint.pinjamBuku}/$idUser');

      if (responseHistoryPeminjaman.statusCode == 200) {
        final ResponseHistoryPeminjaman responseHistory = ResponseHistoryPeminjaman.fromJson(responseHistoryPeminjaman.data);

        if (responseHistory.data!.isEmpty) {
          historyPeminjaman.clear();
          change(null, status: RxStatus.empty());
        } else {
          historyPeminjaman.assignAll(responseHistory.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  // View Post Ulasan Buku
  Future<void> kontenBeriUlasan(String idBuku, String NamaBuku) async{
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: GoogleFonts.inriaSans(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: const Color(0xFF56526F),
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          title: Text(
            'Berikan Ulasan Buku',
            style: GoogleFonts.inriaSans(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: const Color(0xFF56526F),
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Form(
                key: formKey,
                child: ListBody(
                  children: <Widget>[

                    Text(
                      'Rating Buku',
                      style: GoogleFonts.averiaGruesaLibre(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    RatingBar.builder(
                      allowHalfRating: false,
                      itemCount: 5,
                      minRating: 1,
                      initialRating: 5,
                      direction: Axis.horizontal,
                      itemSize: 30,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {
                        ratingBuku = value;
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      'Ulasan Buku',
                      style: GoogleFonts.averiaGruesaLibre(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    CustomTextField(
                      preficIcon: const Icon(Icons.reviews),
                      controller: ulasanController,
                      hinText: 'Ulasan Buku',
                      obsureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pleasse input ulasan buku';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(Get.context!).size.width,
                  height: 50,
                  child: TextButton(
                    autofocus: true,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    onPressed: (){
                      postUlasanBuku(idBuku, NamaBuku);
                      Navigator.of(Get.context!).pop();
                    },
                    child: Text(
                      'Simpan Ulasan Buku',
                      style: GoogleFonts.averiaGruesaLibre(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF008A93),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  postUlasanBuku(String buku, String namaBuku) async {
    loadingUlasan(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        int ratingBukuInt = ratingBuku.round();
        final response = await ApiProvider.instance().post(Endpoint.ulasanBuku,
            data: dio.FormData.fromMap(
                {
                  "Rating": ratingBukuInt,
                  "BukuID": buku,
                  "Ulasan": ulasanController.text.toString()
                }
            )
        );
        if (response.statusCode == 201) {
          _showMyDialog(
                  (){
                Navigator.of(Get.context!).pop();
              },
              "Pemberitahuan",
              "Ulasan Buku $namaBuku berhasil di simpan",
              "Ok");
          ulasanController.text = '';

        } else {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "Ulasan Gagal disimpan, Silakan coba kembali",
              "Ok"
          );
        }
      }
      loadingUlasan(false);
    } on dio.DioException catch (e) {
      loadingUlasan(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "${e.response?.data['Message']}",
              "Ok"
          );
        }
      } else {
        _showMyDialog(
              (){
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loadingUlasan(false);
      _showMyDialog(
            (){
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

  Future<void> _showMyDialog(final onPressed, String judul, String deskripsi, String nameButton) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF5F5F5),
          title: Text(
            'Flowbook App',
            style: GoogleFonts.averiaGruesaLibre(
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
              color: const Color(0xFF56526F),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  judul,
                  style: GoogleFonts.averiaGruesaLibre(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18.0
                  ),
                ),
                Text(
                  deskripsi,
                  style: GoogleFonts.averiaGruesaLibre(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 18.0
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              autofocus: true,
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
              ),
              onPressed: onPressed,
              child: Text(
                nameButton,
                style: GoogleFonts.averiaGruesaLibre(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF008A93),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
