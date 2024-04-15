import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_all_book.dart';
import '../../../data/model/response_kategori.dart';
import '../../../data/model/buku/response_search_book.dart';
import '../../../data/provider/api_provider.dart';

class ExplorerController extends GetxController with StateMixin {

  var dataAllBook = RxList<DataBook>();
  var dataKategori = RxList<DataKategori>();
  var searchBook = RxList<DataSearch>();

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataBook();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get Data Buku
  Future<void> getDataBook() async{
    dataAllBook.clear();
    dataKategori.clear();
    change(null, status: RxStatus.loading());

    try {

      final keyword = searchController.text.toString();
      final response;

      if(keyword == ''){
        response = await ApiProvider.instance().get('${Endpoint.buku}all/buku/null');
      }else{
        response = await ApiProvider.instance().get('${Endpoint.buku}all/buku/$keyword');
      }
      final responseKategori = await ApiProvider.instance().get(Endpoint.kategoriBuku);

      if (response.statusCode == 200 && responseKategori.statusCode == 200) {
        final ResponseAllBook responseBuku = ResponseAllBook.fromJson(response.data);
        final ResponseKategori responseBukuKategori = ResponseKategori.fromJson(responseKategori.data);

        if(responseBuku.data!.isEmpty && responseBukuKategori.data!.isEmpty){
          dataAllBook.clear();
          dataKategori.clear();
          change(null, status: RxStatus.empty());
        }else{
          dataAllBook.assignAll(responseBuku.data!);
          dataKategori.assignAll(responseBukuKategori.data!);
          change(responseBuku.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }

    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getDataSearchBook() async {
    try {
      change(null, status: RxStatus.loading()); // Ubah status menjadi loading

      final keyword = searchController.text.toString();
      final response;

      if(keyword == ''){
        response = await ApiProvider.instance().get('${Endpoint.buku}all/buku/null');
      }else{
        response = await ApiProvider.instance().get('${Endpoint.buku}all/buku/$keyword');
      }

      if (response.statusCode == 200) {
        final responseData = ResponseSearchBook.fromJson(response.data);

        if (responseData.data!.isEmpty) {
          searchBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          searchBook.assignAll(responseData.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        // Tangani kasus jika status kode respons bukan 200
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioError catch (e) {
      // Tangani kesalahan jika terjadi kesalahan dengan Dio
      handleError(e);
    } catch (e) {
      // Tangani kesalahan lainnya
      handleError(e);
    }
  }

  void handleError(dynamic e) {
    if (e is DioError) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } else {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
