import 'package:get/get.dart';
import 'package:messenger_app/app/modules/chat/views/chat_room_views.dart';

import '../modules/authentication/authentication_binding.dart';
import '../modules/authentication/authentication_page.dart';
import '../modules/chat/chat_binding.dart';
import '../modules/chat/chat_page.dart';
import '../modules/main/main_binding.dart';
import '../modules/main/main_page.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_page.dart';
import '../modules/search/search_binding.dart';
import '../modules/search/search_page.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = AppRoutes.initial;
  static final pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const AuthenticationPage(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.searching,
      page: () => const SearchingPage(),
      binding: SearchingBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.chatRooms,
      page: () => const ChatRoomViews(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    )
  ];
}
