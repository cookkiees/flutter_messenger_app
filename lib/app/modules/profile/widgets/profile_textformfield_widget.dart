import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main/main_controller.dart';

class ProfileTextFormFieldWidget extends StatelessWidget {
  const ProfileTextFormFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
  });
  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    return TextFormField(
      controller: controller,
      cursorColor: mainController.isPrimaryDark.value,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.urbanist(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: mainController.isPrimaryDark.value.withOpacity(0.5),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.3,
            color: mainController.isPrimaryDark.value,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.3,
            color: mainController.isPrimaryDark.value,
          ),
        ),
      ),
    );
  }
}
