import 'package:get/get.dart';
import 'package:messenger_app/app/modules/authentication/authentication_controller.dart';
import 'chat_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<AuthenticationController>(() => AuthenticationController());
  }
}
