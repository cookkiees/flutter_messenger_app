import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger_app/app/modules/authentication/authentication_controller.dart';

class ProfileController extends AuthenticationController {
  var isExpandedUpdateStatus = false.obs;
  toogleExpandedUpdateStatus() {
    isExpandedUpdateStatus.value = !isExpandedUpdateStatus.value;
  }

  var isExpandedSettings = false.obs;
  toogleExpandedSettings() {
    isExpandedSettings.value = !isExpandedSettings.value;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
}
