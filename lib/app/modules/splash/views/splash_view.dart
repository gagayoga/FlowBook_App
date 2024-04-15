import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reyhan_flowbook/app/data/provider/storage_provider.dart';
import 'package:reyhan_flowbook/app/routes/app_pages.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    String statusUser = StorageProvider.read(StorageKey.status);

    Future.delayed(
        const Duration(milliseconds: 6000), ( (){
          if (statusUser == 'logged'){
            Get.offAllNamed(Routes.DASHBOARD);
          }else{
            Get.offAllNamed(Routes.ONBOARDING);
          }
    })
    );

    return Scaffold(
        body: SafeArea(
          child: Container(
            // memberikan background color
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash/bg_flowbook.png'),
                  fit: BoxFit.cover,
                )),
            child: Center(
              //  gambar logo splash screen
              child: Lottie.asset(
                'assets/images/splash/logo_flowbook.json',
                repeat: false
              )
            ),
          ),
        )
    );
  }
}
