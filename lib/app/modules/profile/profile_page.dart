import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../authentication/authentication_controller.dart';
import '../main/main_controller.dart';
import 'profile_controller.dart';
import 'views/settings_views.dart';
import 'views/update_status_views.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController auth = Get.find<AuthenticationController>();
    MainController mainController = Get.put(MainController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 32),
          child: Obx(
            () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.green,
                          backgroundImage:
                              NetworkImage("${auth.userModel.value.photoUrl}"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${auth.user == null ? '' : auth.user!.displayName}',
                        style: GoogleFonts.urbanist(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: mainController.isPrimaryDark.value,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        auth.userModel.value.email!,
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: mainController.isPrimaryDark.value,
                        ),
                      ),
                      const SizedBox(height: 38),
                      const UdapteStatusViews(),
                      Divider(
                        thickness: 0.2,
                        indent: 16,
                        endIndent: 16,
                        color: mainController.isPrimaryDark.value,
                      ),
                      const SettingsViews(),
                      Divider(
                        thickness: 0.2,
                        indent: 16,
                        endIndent: 16,
                        color: mainController.isPrimaryDark.value,
                      ),
                      // const SizedBox(height: 24),
                      // ElevatedButton(
                      //   onPressed: () => auth.handleSignOut(),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: mainController.isPrimaryDark.value,
                      //   ),
                      //   child: Text(
                      //     'Logout',
                      //     style: GoogleFonts.urbanist(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w600,
                      //       color: mainController.isPrimaryLight.value,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
