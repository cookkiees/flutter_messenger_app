import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main/main_controller.dart';
import '../profile_controller.dart';

class SettingsViews extends StatelessWidget {
  const SettingsViews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    ProfileController controller = Get.put(ProfileController());
    return Obx(
      () => Column(
        children: [
          ListTile(
            dense: true,
            leading: Icon(
              Icons.settings,
              size: 24.0,
              color: mainController.isPrimaryDark.value,
            ),
            title: Text(
              "Settings",
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: mainController.isPrimaryDark.value,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => controller.toogleExpandedSettings(),
              child: Icon(
                controller.isExpandedSettings.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 24.0,
                color: mainController.isPrimaryDark.value,
              ),
            ),
          ),
          if (controller.isExpandedSettings.value)
            const SizedBox(
              height: 200,
              width: double.infinity,
            )
          else
            const SizedBox.shrink()
        ],
      ),
    );
  }
}
