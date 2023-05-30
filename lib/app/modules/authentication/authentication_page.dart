import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/utils/my_colors.dart';
import 'authentication_controller.dart';

class AuthenticationPage extends GetView<AuthenticationController> {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Messenger',
                  style: GoogleFonts.anton(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: MyColors.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Experience the benefits by logging in to your personal account.',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: MyColors.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 200),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: MyColors.bone,
                  foregroundColor: MyColors.primary,
                ),
                icon: SvgPicture.asset('assets/icons/facebook.svg'),
                label: Text(
                  ' Continue with Facebook',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MyColors.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => controller.handleSignIn(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: MyColors.bone,
                  foregroundColor: MyColors.primary,
                ),
                icon: SvgPicture.asset('assets/icons/google.svg'),
                label: Text(
                  ' Continue with Google',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MyColors.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: MyColors.bone,
                  foregroundColor: MyColors.primary,
                ),
                icon: SvgPicture.asset('assets/icons/apple.svg'),
                label: Text(
                  ' Continue with Apple',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MyColors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
