import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_book_bykategori.dart';
import '../../../data/provider/api_provider.dart';

class BookbykategoriController extends GetxController with StateMixin {
  var dataBookByKategori = RxList<DataBookKategori>();

  @override
  void onInit() {
    super.onInit();
    getDataBookKategori();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataBookKategori() async {
    dataBookByKategori.clear();
    change(null, status: RxStatus.loading());

    try {
      final idKategori = Get.parameters['idKategori'];
      final responseBook = await ApiProvider.instance().get(
          '${Endpoint.bukuByKategori}/$idKategori');

      if (responseBook.statusCode == 200) {
        final ResponseBookBykategori responseDataBook = ResponseBookBykategori.fromJson(responseBook.data);

        if (responseDataBook.data!.isEmpty) {
          dataBookByKategori.clear();
          change(null, status: RxStatus.empty());
        } else {
          dataBookByKategori.assignAll(responseDataBook.data!);
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
