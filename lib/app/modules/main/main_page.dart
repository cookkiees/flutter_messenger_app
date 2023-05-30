import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:messenger_app/app/modules/search/search_page.dart';

import '../../theme/utils/my_colors.dart';
import '../chat/chat_page.dart';
import '../profile/profile_page.dart';
import 'main_controller.dart';
import 'widgets/main_appbar_widget.dart';
import 'widgets/main_drawer_widget.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.mainScaffoldKey,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: MainAppBarWidget(),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.pageIndex.value,
          children: [
            if (controller.isLoading.value)
              Center(child: CupertinoActivityIndicator(color: Colors.grey[900]))
            else
              const ChatPage(),
            if (controller.isLoading.value)
              Center(child: CupertinoActivityIndicator(color: Colors.grey[900]))
            else
              const SearchingPage(),
            if (controller.isLoading.value)
              Center(child: CupertinoActivityIndicator(color: Colors.grey[900]))
            else
              const ProfilePage(),
          ],
        ),
      ),
      drawer: const MainDrawerWidget(),
      bottomNavigationBar: Obx(
        () => Container(
          height: 86,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: controller.isPrimaryLight.value,
          alignment: Alignment.topCenter,
          child: GNav(
            gap: 8,
            haptic: true,
            iconSize: 24,
            tabBorderRadius: 8,
            backgroundColor: controller.isPrimaryLight.value,
            color: controller.isChangeTheme.value
                ? MyColors.primary
                : MyColors.onPrimary,
            activeColor: controller.isChangeTheme.value
                ? MyColors.onPrimary
                : MyColors.primary,
            tabBackgroundColor: controller.isPrimaryDark.value,
            curve: Curves.bounceIn,
            tabActiveBorder: Border.all(
              color: controller.isChangeTheme.value
                  ? MyColors.primary
                  : MyColors.onPrimary,
              width: 0.5,
            ),
            tabBorder: Border.all(
              color: controller.isChangeTheme.value
                  ? MyColors.primary
                  : MyColors.onPrimary,
              width: 0.5,
            ),
            selectedIndex: controller.pageIndex.value,
            onTabChange: controller.onTabSelected,
            duration: const Duration(milliseconds: 900),
            mainAxisAlignment: MainAxisAlignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            tabs: [
              GButton(
                icon: Icons.chat,
                text: 'Chat',
                textStyle: GoogleFonts.urbanist(
                    fontSize: 18,
                    color: controller.isChangeTheme.value
                        ? MyColors.onPrimary
                        : MyColors.primary),
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
                textStyle: GoogleFonts.urbanist(
                    fontSize: 18,
                    color: controller.isChangeTheme.value
                        ? MyColors.onPrimary
                        : MyColors.primary),
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                textStyle: GoogleFonts.urbanist(
                    fontSize: 18,
                    color: controller.isChangeTheme.value
                        ? MyColors.onPrimary
                        : MyColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
