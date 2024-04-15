import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hinText;
  final bool obsureText;
  final Widget? preficIcon;
  final Widget? surficeIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hinText,
    required this.obsureText,
    this.preficIcon,
    this.surficeIcon,
    this.validator,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    const Color backgroundInput = Color(0xFFF8F8F8);
    const Color colorBorder = Color(0xFF020925);
    const Color background = Color(0xFF03010E);
    const Color colorText = Color(0xFFEA1818);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        style: GoogleFonts.inriaSans(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: background,
        ),
        obscureText: obsureText,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: preficIcon,
          fillColor: backgroundInput,
          suffixIcon: surficeIcon,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorBorder.withOpacity(0.90),
              ),
              borderRadius: BorderRadius.circular(20.20)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorBorder.withOpacity(0.90),
              ),
              borderRadius: BorderRadius.circular(20.20)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorBorder.withOpacity(0.90),
              ),
              borderRadius: BorderRadius.circular(20.20)),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorBorder.withOpacity(0.90),
            ),
            borderRadius: BorderRadius.circular(20.20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
          hintText: hinText,
          errorStyle: GoogleFonts.inriaSans(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: colorText,
          ),
          hintStyle: GoogleFonts.inriaSans(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: background,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
