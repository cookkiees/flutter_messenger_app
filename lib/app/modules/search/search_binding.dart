import 'package:get/get.dart';

import 'search_controller.dart';

class SearchingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchingController>(() => SearchingController());
  }
}
