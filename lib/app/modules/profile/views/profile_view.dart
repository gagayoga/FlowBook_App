import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // size
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;


    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash/bg_flowbook.png',
            ),
            fit: BoxFit.cover,
          )
        ),
        child: SizedBox(
          child: Stack(
            children: [

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: width,
                  height: 300,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    color: Colors.black
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Obx((){
                    var dataUser = controller.detailProfile.value;

                    if (controller.detailProfile.value == null){
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF008A93)),
                        ),
                      );
                    }else{
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: controller.formKey,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async{
                                          await controller.getDataUser();},
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.asset(
                                            'assets/images/icon_profile.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 15,
                                      ),

                                      Text(
                                        dataUser!.namaLengkap.toString(),
                                        style: GoogleFonts.averiaGruesaLibre(
                                            fontSize: 26.0,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 5,
                                      ),

                                      Text(
                                        dataUser.bio.toString(),
                                        style: GoogleFonts.averiaGruesaLibre(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 25,
                                      ),

                                      kontenDataUser(
                                          controller.namalengkapController,
                                          'Masukan nama lengkap'
                                      ),

                                      const SizedBox(
                                        height: 5,
                                      ),

                                      kontenDataUser(
                                          controller.usernameController,
                                          'Masukan username'
                                      ),

                                      const SizedBox(
                                        height: 5,
                                      ),

                                      kontenDataUser(
                                          controller.emailController,
                                          'Masukan email'
                                      ),

                                      const SizedBox(
                                        height: 5,
                                      ),

                                      kontenDataUser(
                                          controller.bioController,
                                          'Masukan bio'
                                      ),

                                      const SizedBox(
                                        height: 5,
                                      ),

                                      kontenDataUser(
                                          controller.teleponController,
                                          'Masukan telepom'
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: double.infinity,
                                        height: 45.0,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Colors.black,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20.20))),
                                            onPressed: (){
                                              controller.updateProfilePost();
                                            },
                                            child: Obx(() => controller.loading.value?
                                            const CircularProgressIndicator(
                                              color: Color(0xFF008A93),
                                            ): Text(
                                              "Update Profile",
                                              style: GoogleFonts.averiaGruesaLibre(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: const Color(0xFF008A93),),
                                            ))
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: height * 0.020,
                            ),

                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: double.infinity,
                                        height: 45.0,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Colors.red,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20.20))),
                                            onPressed: (){
                                              controller.logout();
                                            },
                                            child: Obx(() => controller.loadingLogout.value?
                                            const CircularProgressIndicator(
                                              color: Color(0xFF008A93),
                                            ): Text(
                                              "Logout",
                                              style: GoogleFonts.averiaGruesaLibre(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,),
                                            ))
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget kontenDataUser(TextEditingController controller, String messageValidator){
    return TextFormField(
      style: GoogleFonts.averiaGruesaLibre(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Colors.black.withOpacity(0.50),
      ),
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: Color(0xFF008A93),
              ),
              borderRadius: BorderRadius.circular(20.20)),
          enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: Color(0xFF008A93),
              ),
              borderRadius: BorderRadius.circular(20.20)),
          errorBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: Color(0xFF008A93),
              ),
              borderRadius: BorderRadius.circular(20.20)),
          border: UnderlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: Color(0xFF008A93),
              ),
              borderRadius: BorderRadius.circular(20.20)),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 20.0),
          hintStyle: GoogleFonts.averiaGruesaLibre(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black.withOpacity(0.50),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return messageValidator;
        }
        return null;
      },
    );
  }
}
