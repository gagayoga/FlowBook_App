import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reyhan_flowbook/app/routes/app_pages.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(milliseconds: 6000), ( (){
      Get.offAllNamed(Routes.ONBOARDING);
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
