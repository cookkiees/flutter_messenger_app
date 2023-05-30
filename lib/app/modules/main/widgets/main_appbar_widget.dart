import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_controller.dart';

class MainAppBarWidget extends GetView<MainController> {
  const MainAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => controller.openDrawer(),
          icon: const Icon(Icons.sort, size: 32),
        ),
        title: Text(
          (controller.pageIndex.value == 0)
              ? "CHAT"
              : (controller.pageIndex.value == 1)
                  ? "SEARCH"
                  : "PROFILE",
          style: GoogleFonts.anton(
            fontSize: 18,
            letterSpacing: 3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => controller.setThemes(),
              child: Container(
                width: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.isPrimaryLight.value,
                  border: Border.all(
                    width: 0.5,
                    color: controller.isChangeTheme.value
                        ? Colors.grey[100]!
                        : Colors.grey[900]!,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.isChangeTheme.value ? 'DARK' : 'LIGHT',
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
