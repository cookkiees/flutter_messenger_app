import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_controller.dart';

class MainDrawerWidget extends GetView<MainController> {
  const MainDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(),
            child: Icon(
              Icons.apple,
              size: 150,
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'messenger',
              style: GoogleFonts.anton(
                fontSize: 14,
                letterSpacing: 2,
                color: Colors.grey,
              ),
              children: [
                TextSpan(
                  text: '\nv 1.0.7',
                  style: GoogleFonts.anton(
                    fontSize: 12,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
