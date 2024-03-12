import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color backgroundInput = Color(0xFFD9D9D9);

    const Color primary =  Color(0xFF008A93);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // memberikan background color
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/splash/bg_flowbook.png'),
            fit: BoxFit.cover,
          )),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text Login
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Text(
                            'Login',
                            style: GoogleFonts.averiaGruesaLibre(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // TextBox Username
                        SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Alamat Email',
                                    style: GoogleFonts.averiaGruesaLibre(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            )),

                        TextFormField(
                          controller: controller.emailController,
                          style: GoogleFonts.averiaGruesaLibre(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black.withOpacity(0.50),
                          ),
                          decoration: InputDecoration(
                              fillColor: backgroundInput,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(20.20)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(20.20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(20.20)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(20.20)),
                              hintText: 'Masukan Email',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              hintStyle: GoogleFonts.averiaGruesaLibre(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black.withOpacity(0.50),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email tidak boleh kosong';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Email address tidak sesuai';
                            }else if (!value.endsWith('@smk.belajar.id')){
                              return 'Email harus @smk.belajar.id';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        // TextBox Password
                        SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Password',
                                    style: GoogleFonts.averiaGruesaLibre(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            )),

                        Obx(
                              () => TextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.isPasswordHidden.value,
                            style: GoogleFonts.averiaGruesaLibre(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black.withOpacity(0.50),
                            ),
                            decoration: InputDecoration(
                                fillColor: backgroundInput,
                                suffixIcon: InkWell(
                                  child: Icon(
                                    controller.isPasswordHidden.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  onTap: () {
                                    controller.isPasswordHidden.value =
                                    !controller.isPasswordHidden.value;
                                  },
                                ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(20.20)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(20.20)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(20.20)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(20.20)),
                                hintText: 'Masukan Password',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                hintStyle: GoogleFonts.averiaGruesaLibre(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black.withOpacity(0.50),
                                )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password tidak boleh kosong';
                                  } else if (value.length < 8){
                                    return 'Panjang password harus lebih dari 8';
                                  }
                                  // Validasi setidaknya satu huruf besar
                                  else if (!value.contains(RegExp(r'[A-Z]'))) {
                                    return 'Password harus mengandung satu huruf besar';
                                  }
                                  // Validasi setidaknya satu karakter khusus
                                  else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                    return 'Password harus mengandung satu karakter khusus';
                                  }
                                  // Validasi setidaknya satu angka
                                  else if (!value.contains(RegExp(r'[0-9]'))) {
                                    return 'Password harus mengandung minimal 1 angka';
                                  }
                                  return null;
                                },
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),

                        // Button Login
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30),
                            child: Column(
                              children: [
                                SizedBox(
                                    width: double.infinity,
                                    height: 50.0,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            Colors.black.withOpacity(0.70),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20.20))),
                                        onPressed: () => controller.login(),
                                        child: Obx(() => controller.loadinglogin.value?
                                        const CircularProgressIndicator(
                                          color: primary,
                                        ): Text(
                                          "Login",
                                          style: GoogleFonts.averiaGruesaLibre(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white),
                                        ))
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Text Register
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(
                                    'Belum punya akun?',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offAllNamed(Routes.REGISTER);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                  ),
                                  child: Text('Daftar',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: primary,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // Image Bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/images/splash/icon_buku.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
