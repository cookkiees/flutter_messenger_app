import 'package:get/get.dart';
import 'package:messenger_app/app/modules/search/search_controller.dart';

// import '../profile/profile_controller.dart';
// import 'chat_controller.dart';
import '../chat/chat_controller.dart';
import '../profile/profile_controller.dart';
import 'main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SearchingController>(() => SearchingController());
  }
}
