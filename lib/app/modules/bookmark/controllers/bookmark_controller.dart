import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_koleksi_book.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class BookmarkController extends GetxController with StateMixin{

  var koleksiBook = RxList<DataKoleksiBook>();
  // var historyPeminjaman = Rxn<List<DataHistory>>();
  String idUser = StorageProvider.read(StorageKey.idUser);

  // Jumlah Data
  int get jumlahKoleksiBook => koleksiBook.length;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());

    try {
      final responseKoleksiBuku = await ApiProvider.instance().get(
          '${Endpoint.koleksiBook}/$idUser');
      // final responseHistoryPeminjaman = await ApiProvider.instance().get(
      //     '${Endpoint.historyPeminjaman}/$idUser');

      if (responseKoleksiBuku.statusCode == 200) {
        final ResponseKoleksiBook responseKoleksi = ResponseKoleksiBook.fromJson(responseKoleksiBuku.data);
        //final ResponseHistoryPeminjaman responseHistory = ResponseHistoryPeminjaman.fromJson(responseHistoryPeminjaman.data);

        if (responseKoleksi.data!.isEmpty) {
          koleksiBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          koleksiBook.assignAll(responseKoleksi.data!);
          //historyPeminjaman(responseHistory.data!);
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
}
