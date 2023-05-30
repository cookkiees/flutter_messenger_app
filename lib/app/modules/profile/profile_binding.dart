import 'package:get/get.dart';
import 'package:messenger_app/app/modules/authentication/authentication_controller.dart';

import 'profile_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AuthenticationController>(() => AuthenticationController());
  }
}
