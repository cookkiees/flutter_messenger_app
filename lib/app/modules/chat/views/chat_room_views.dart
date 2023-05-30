import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger_app/app/modules/chat/chat_controller.dart';
import 'package:messenger_app/app/modules/main/main_controller.dart';
import 'package:messenger_app/app/theme/utils/my_colors.dart';

import '../../authentication/authentication_controller.dart';
import '../widgets/chat_item_messenger_widget.dart';

class ChatRoomViews extends GetView<ChatController> {
  const ChatRoomViews({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    final auth = Get.find<AuthenticationController>();

    final String chatId =
        (Get.arguments as Map<String, dynamic>)["chatId"].toString();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        leadingWidth: 98,
        toolbarHeight: 70,
        leading: InkWell(
          onTap: () => Get.back(),
          // ignore: prefer_const_constructors
          child: Row(
            children: [
              const SizedBox(width: 16),
              const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 24,
                child: StreamBuilder<DocumentSnapshot<Object?>>(
                  stream: controller.streamFriendData(
                      (Get.arguments as Map<String, dynamic>)["friendEmail"]),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var dataFriend =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          dataFriend["photoUrl"],
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return const Text('data');
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
        title: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: controller.streamFriendData(
              (Get.arguments as Map<String, dynamic>)["friendEmail"]),
          builder: (context, snapFriendUser) {
            if (snapFriendUser.connectionState == ConnectionState.active) {
              var dataFriend =
                  snapFriendUser.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataFriend["name"],
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: mainController.isPrimaryDark.value,
                    ),
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Loading...',
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MyColors.onPrimary,
                  ),
                ),
                Text(
                  'Loading...',
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MyColors.onPrimary,
                  ),
                )
              ],
            );
          },
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamChats(chatId),
                builder: (context, snapshot) {
                  debugPrint(" jancookk $chatId");
                  if (snapshot.connectionState == ConnectionState.active) {
                    var allData = snapshot.data!.docs;
                    Timer(
                      Duration.zero,
                      () => controller.scrollC
                          .jumpTo(controller.scrollC.position.maxScrollExtent),
                    );
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      controller: controller.scrollC,
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              const SizedBox(height: 16),
                              Obx(() {
                                return Text(
                                  '${allData[index]["groupTime"]}',
                                  style: GoogleFonts.urbanist(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          mainController.isPrimaryDark.value),
                                );
                              }),
                              ChatItemMessegerWidget(
                                time: "${allData[index]["time"]}",
                                msg: "${allData[index]["msg"]}",
                                isSender: allData[index]["pengirim"] ==
                                    auth.userModel.value.email!,
                              ),
                            ],
                          );
                        } else {
                          if (allData[index]["groupTime"] ==
                              allData[index - 1]["groupTime"]) {
                            return ChatItemMessegerWidget(
                              msg: "${allData[index]["msg"]}",
                              isSender: allData[index]["pengirim"] ==
                                  auth.userModel.value.email!,
                              time: "${allData[index]["time"]}",
                            );
                          } else {
                            return Column(
                              children: [
                                Obx(() {
                                  return Text(
                                    '${allData[index]["groupTime"]}',
                                    style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            mainController.isPrimaryDark.value),
                                  );
                                }),
                                ChatItemMessegerWidget(
                                  msg: "${allData[index]["msg"]}",
                                  isSender: allData[index]["pengirim"] ==
                                      auth.userModel.value.email!,
                                  time: "${allData[index]["time"]}",
                                ),
                              ],
                            );
                          }
                        }
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.chatC,
                      focusNode: controller.focusNode,
                      cursorColor: MyColors.onPrimary,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.emoji_emotions,
                          size: 24.0,
                          color: MyColors.onPrimary,
                        ),
                        fillColor: MyColors.bone,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(
                            color: mainController.isPrimaryDark.value,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () => controller.newChat(
                        auth.userModel.value.email!,
                        Get.arguments as Map<String, dynamic>,
                        controller.chatC.text),
                    child: const CircleAvatar(
                      radius: 26.0,
                      backgroundColor: MyColors.bone,
                      child: Icon(
                        Icons.send,
                        color: MyColors.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
