import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger_app/app/modules/authentication/authentication_controller.dart';
import 'package:messenger_app/app/modules/chat/chat_controller.dart';
import 'package:messenger_app/app/modules/main/main_controller.dart';
import 'package:messenger_app/app/theme/utils/my_colors.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    final auth = Get.find<AuthenticationController>();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.chatsStream(auth.userModel.value.email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listDocsChats = snapshot.data!.docs;
            if (listDocsChats.isEmpty) {
              return Center(
                child: Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your freindlist is still empty !! ",
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w300,
                          color: mainController.isPrimaryDark.value,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => mainController.onTabSelected(1),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                mainController.isPrimaryDark.value),
                        child: Text(
                          'Find now',
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            color: mainController.isPrimaryLight.value,
                          ),
                        ),
                      )
                    ],
                  );
                }),
              );
            }
            // sorting berdasarkan lastimenya
            return ListView.builder(
              itemCount: listDocsChats.length,
              padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller.chatsFriendStream(
                    listDocsChats[index]["connection"],
                  ),
                  builder: (context, snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.active) {
                      var data = snapshot2.data!.data();
                      return InkWell(
                        onTap: () => controller.goToChatRoom(
                          listDocsChats[index].id,
                          auth.userModel.value.email!,
                          listDocsChats[index]["connection"],
                        ),
                        child: Card(
                          color: MyColors.bone,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              backgroundImage: NetworkImage(
                                "${data!["photoUrl"]}",
                              ),
                            ),
                            title: Text("${data["name"]}"),
                            subtitle: Text("${data["email"]}"),
                            trailing: (listDocsChats[index]["totalUnread"] == 0)
                                ? const SizedBox.shrink()
                                : Chip(
                                    backgroundColor: MyColors.onPrimary,
                                    label: Text(
                                      '${listDocsChats[index]["totalUnread"]}',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: MyColors.primary,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  },
                );
              },
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
