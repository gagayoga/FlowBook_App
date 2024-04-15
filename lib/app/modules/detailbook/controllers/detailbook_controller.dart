import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../components/customTextFieldPeminjaman.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_detail_buku.dart';
import '../../../data/model/peminjaman/response_peminjaman.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class DetailbookController extends GetxController with StateMixin{

  var dataDetailBook = Rxn<DataDetailBuku>();
  final id = Get.parameters['id'];

  var loading = false.obs;

  late String formattedToday;
  late String formattedTwoWeeksLater;

  // CheckBox
  var isChecked = false.obs;

  void toggleCheckBox() {
    isChecked.value = !isChecked.value;
  }

  // Data Peminjaman
  late String statusDataPeminjaman;

  @override
  void onInit() {
    super.onInit();
    getDataDetailBuku(id);

    // Get Tanggal hari ini
    DateTime todayDay = DateTime.now();

    // Menambahkan 14 hari ke tanggal hari ini
    DateTime twoWeeksLater = todayDay.add(const Duration(days: 14));

    // Format tanggal menjadi string menggunakan intl package
    formattedToday = DateFormat('yyyy-MM-dd').format(todayDay);
    formattedTwoWeeksLater = DateFormat('yyyy-MM-dd').format(twoWeeksLater);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataDetailBuku(String? idBuku) async {
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(
          '${Endpoint.detailBook}/$idBuku');

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDetailBuku responseBuku = ResponseDetailBuku.fromJson(responseDetailBuku.data);

        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          dataDetailBook(responseBuku.data);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> addKoleksiBuku(BuildContext context) async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().post(
        Endpoint.koleksiBook,
        data: {
          "UserID": userID,
          "BukuID": bukuID,
        },
      );

      if (response.statusCode == 201) {
        String judulBuku = Get.parameters['judul'].toString();
        Fluttertoast.showToast(
          msg: "Buku $judulBuku berhasil disimpan di koleksi buku",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: const Color(0xFF008A93),
        );
        getDataDetailBuku(bukuID);
      } else {
        Fluttertoast.showToast(
          msg: "Buku gagal disimpan, silakan coba kembali",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Fluttertoast.showToast(
            msg: e.response?.data?['message'] ?? "Terjadi kesalahan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xFFF5F5F5),
            textColor: Colors.black,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: e.message ?? "Terjadi kesalahan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
    } catch (e) {
      loading(false);
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFF5F5F5),
        textColor: Colors.black,
      );
    }
  }

  deleteKoleksiBook(String id, BuildContext context) async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().delete(
          '${Endpoint.hapusKoleksi}$userID/koleksi/$bukuID');

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Buku berhasil dihapus di koleksi buku",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: const Color(0xFF008A93),
        );
        getDataDetailBuku(id);
      } else {
        Fluttertoast.showToast(
          msg: "Buku gagal dihapus, silakan coba kembali",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Fluttertoast.showToast(
            msg: e.response?.data?['Message'] ?? "Terjadi kesalahan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xFFF5F5F5),
            textColor: Colors.black,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: e.message ?? "Terjadi kesalahan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
    } catch (e) {
      loading(false);
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFF5F5F5),
        textColor: Colors.black,
      );
    }
  }

  addPeminjamanBuku() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var bukuID = id.toString();

      var responsePostPeminjaman = await ApiProvider.instance().post(Endpoint.pinjamBuku,
        data: {
          "BukuID": bukuID,
        },
      );

      if (responsePostPeminjaman.statusCode == 201) {
        ResponsePeminjaman responsePeminjaman = ResponsePeminjaman.fromJson(responsePostPeminjaman.data!);
        String judulBuku = Get.parameters['judul'].toString();
        String peminjamanID = responsePeminjaman.data!.peminjamanID.toString();

        _showMyDialog(
              () {
            Get.offAllNamed(Routes.BUKTIPEMINJAMAN, parameters: {
              'idPeminjaman': peminjamanID,
              'asalHalaman' : 'detailBuku',
            });
            getDataDetailBuku(bukuID);
          },
          "Peminjaman Berhasil",
          "Buku $judulBuku berhasil dipinjam",
          "Oke",
        );
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          "Buku gagal dipinjam, silakan coba kembali",
          "Ok",
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                () {
              Navigator.pop(Get.context!, 'OK');
            },
            "Pemberitahuan",
            "${e.response?.data?['message']}",
            "Ok",
          );
        }
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loading(false);
      _showMyDialog(
            () {
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

  Future<void> showConfirmPeminjaman(final onPressed, String nameButton) async {
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
            'Form Peminjaman Buku',
            style: GoogleFonts.averiaGruesaLibre(
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
              color: const Color(0xFF56526F),
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: ListBody(
                children: <Widget>[

                  CustomTextFieldPeminjaman(
                    InitialValue: Get.parameters['judul'].toString(),
                    labelText: 'Judul Buku',
                    obsureText: false,
                  ),

                  CustomTextFieldPeminjaman(
                    preficIcon: Icon(Icons.calendar_today),
                    InitialValue: formattedToday.toString(),
                    labelText: 'Tanggal Peminjaman',
                    obsureText: false,
                  ),

                  CustomTextFieldPeminjaman(
                    preficIcon: Icon(Icons.calendar_today),
                    InitialValue: formattedTwoWeeksLater.toString(),
                    labelText: 'Deadline Pengembalian',
                    obsureText: false,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        value: isChecked.value,
                        onChanged: (value) {
                          toggleCheckBox();
                        },
                        activeColor: const Color(0xFF56526F),
                      )
                      ),
                      Expanded(
                        child: Text(
                          "Setuju dengan jadwal peminjaman waktu",
                          maxLines: 1,
                          style: GoogleFonts.averiaGruesaLibre(
                            fontSize: 10.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF1B1B1D),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            Navigator.pop(Get.context!, 'OK');
                          },
                          child: Text(
                            'Batal',
                            style: GoogleFonts.averiaGruesaLibre(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            if (!isChecked.value) {
                              return;
                            }
                            Navigator.pop(Get.context!, 'OK');
                            addPeminjamanBuku();
                          },
                          child: Text(
                            nameButton,
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
              ),
            ),
          ],
        );
      },
    );
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
