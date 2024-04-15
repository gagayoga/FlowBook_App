import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../routes/app_pages.dart';
import 'package:dio/dio.dart' as dio;

class RegisterController extends GetxController {

  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  registerPost() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        var response = await ApiProvider.instance().post(Endpoint.register,
            data:
            {
              "username": usernameController.text.toString(),
              "email": emailController.text.toString(),
              "password": passwordController.text.toString()
            }
        );
        if (response.statusCode == 201) {
          String username = usernameController.text.toString();
          _showMyDialog(
                  (){
                Get.to( Get.offAllNamed(Routes.LOGIN), transition: Transition.cupertinoDialog);
              },
              "Registrasi Berhasil",
              "Selamat Datang $username, Silakan Login Dulu",
              "Next");
        } else {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "Login Gagal, Coba kembali masuk dengan akun anda",
              "Ok"
          );
        }
      }
      loadinglogin(false);
    } on DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "${e.response?.data?['Message']}",
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
      loadinglogin(false);
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
