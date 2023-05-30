import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger_app/app/modules/authentication/authentication_controller.dart';

import '../../theme/utils/my_colors.dart';
import '../main/main_controller.dart';
import 'search_controller.dart';

class SearchingPage extends GetView<SearchingController> {
  const SearchingPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    final auth = Get.find<AuthenticationController>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverStickyHeader(
            header: Obx(
              () {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: mainController.isPrimaryLight.value,
                  child: TextFormField(
                    onChanged: (value) => controller.searchFriend(
                        value, auth.userModel.value.email!),
                    controller: controller.search,
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: mainController.isPrimaryDark.value,
                    ),
                    cursorColor: mainController.isPrimaryDark.value,
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: mainController.isPrimaryDark.value,
                        size: 24.0,
                      ),
                      hintText: 'Searching',
                      hintStyle: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: mainController.isPrimaryDark.value,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: mainController.isPrimaryDark.value,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: mainController.isPrimaryDark.value,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            sliver: Obx(
              () {
                if (controller.tempSearch.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Discover friends by name or email ! ! !',
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: mainController.isPrimaryDark.value,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SliverList.builder(
                    itemCount: controller.tempSearch.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: InkWell(
                          onTap: () => auth.addNewConnection(
                              controller.tempSearch[i]['email']),
                          child: Card(
                            color: mainController.isChangeTheme.value
                                ? MyColors.primary
                                : MyColors.bone,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                backgroundImage: NetworkImage(
                                  "${controller.tempSearch[i]['photoUrl']}",
                                ),
                              ),
                              title: Text(
                                "${controller.tempSearch[i]['name']}",
                                style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.onPrimary),
                              ),
                              subtitle: Text(
                                "${controller.tempSearch[i]['email']}",
                                style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                    color: MyColors.onPrimary),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
