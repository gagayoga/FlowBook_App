import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reyhan_flowbook/app/routes/app_pages.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          // memberikan background color
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash/bg_flowbook.png'),
                  fit: BoxFit.cover,
                )),
            child: Center(
              //  gambar logo splash screen
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: SvgPicture.asset(
                          'assets/images/splash/logo_flowbook.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: (){
                                  Get.toNamed(Routes.LOGIN);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.averiaGruesaLibre(
                                      color: const Color(0xFF008A93),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
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
                            child: SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: (){
                                  Get.toNamed(Routes.REGISTER);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: Text(
                                  'Daftar',
                                  style: GoogleFonts.averiaGruesaLibre(
                                      color: const Color(0xFF008A93),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ),
        )
    );
  }
}
