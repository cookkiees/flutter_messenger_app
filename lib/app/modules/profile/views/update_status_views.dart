import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main/main_controller.dart';
import '../profile_controller.dart';
import '../widgets/profile_textformfield_widget.dart';

class UdapteStatusViews extends GetView<ProfileController> {
  const UdapteStatusViews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());

    return Obx(
      () => Column(
        children: [
          ListTile(
            dense: true,
            leading: Icon(
              Icons.update,
              size: 24.0,
              color: mainController.isPrimaryDark.value,
            ),
            title: Text(
              "Update status",
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: mainController.isPrimaryDark.value,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => controller.toogleExpandedUpdateStatus(),
              child: Icon(
                controller.isExpandedUpdateStatus.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 24.0,
                color: mainController.isPrimaryDark.value,
              ),
            ),
          ),
          if (controller.isExpandedUpdateStatus.value)
            Container(
              height: 232,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  ProfileTextFormFieldWidget(
                    hintText: 'Email',
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 12),
                  ProfileTextFormFieldWidget(
                    hintText: 'Name',
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 12),
                  ProfileTextFormFieldWidget(
                    hintText: 'Your Status',
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainController.isPrimaryDark.value),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: mainController.isPrimaryLight.value,
                      ),
                    ),
                  )
                ],
              ),
            )
          else
            const SizedBox.shrink()
        ],
      ),
    );
  }
}
