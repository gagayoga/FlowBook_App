import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/peminjaman/response_detail_peminjaman.dart';
import '../../../data/provider/api_provider.dart';

class BuktipeminjamanController extends GetxController with StateMixin{

  // Get Data
  var detailPeminjaman = Rxn<DetailPeminjaman>();

  final idPeminjaman = Get.parameters['idPeminjaman'].toString();

  @override
  void onInit() {
    super.onInit();
    getDataDetailPeminjaman(idPeminjaman);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataDetailPeminjaman(String? idPinjam) async {
    detailPeminjaman.value == null;
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(
          '${Endpoint.detailPeminjaman}/$idPinjam');

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDetailPeminjaman responseDetailPeminjaman = ResponseDetailPeminjaman.fromJson(responseDetailBuku.data);

        if (responseDetailPeminjaman.data == null) {
          detailPeminjaman.value == null;
          change(null, status: RxStatus.empty());
        } else {
          detailPeminjaman(responseDetailPeminjaman.data);
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
