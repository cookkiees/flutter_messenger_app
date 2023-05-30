import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:messenger_app/app/routes/app_routes.dart';

class ChatController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late FocusNode focusNode;
  late TextEditingController chatC;
  late ScrollController scrollC;
  int totalUnread = 0;

  @override
  void onInit() {
    chatC = TextEditingController();
    scrollC = ScrollController();
    focusNode = FocusNode();

    super.onInit();
  }

  @override
  void onClose() {
    chatC.dispose();
    scrollC.dispose();
    focusNode.dispose();
    super.onClose();
  }

  // for chatroom page
  Stream<QuerySnapshot<Map<String, dynamic>>> streamChats(String chatId) {
    CollectionReference chats = firestore.collection("chats");

    return chats.doc(chatId).collection("chat").orderBy("time").snapshots();
  }

  Stream<DocumentSnapshot<Object?>> streamFriendData(String friendEmail) {
    CollectionReference users = firestore.collection("users");

    return users.doc(friendEmail).snapshots();
  }

  void newChat(String email, Map<String, dynamic> argument, String chat) async {
    if (chat != "") {
      CollectionReference chats =
          FirebaseFirestore.instance.collection("chats");
      CollectionReference users =
          FirebaseFirestore.instance.collection("users");

      String date = DateTime.now().toIso8601String();

      try {
        await chats.doc(argument["chatId"]).collection("chat").add({
          "pengirim": email,
          "penerima": argument["friendEmail"],
          "msg": chat,
          "time": date,
          "isRead": false,
          "groupTime": DateFormat.yMMMMd('en_US').format(DateTime.parse(date)),
        });

        Timer(
          Duration.zero,
          () => scrollC.jumpTo(scrollC.position.maxScrollExtent),
        );

        chatC.clear();

        await users
            .doc(email)
            .collection("chats")
            .doc(argument["chatId"])
            .update({
          "lastTime": date,
        });

        final checkChatsFriend = await users
            .doc(argument["friendEmail"])
            .collection("chats")
            .doc(argument["chatId"])
            .get();

        if (checkChatsFriend.exists) {
          // exist on friend DB
          // first check total unread
          final checkTotalUnread = await chats
              .doc(argument["chatId"])
              .collection("chat")
              .where("isRead", isEqualTo: false)
              .where("pengirim", isEqualTo: email)
              .get();

          // total unread for friend
          totalUnread = checkTotalUnread.docs.length;

          await users
              .doc(argument["friendEmail"])
              .collection("chats")
              .doc(argument["chatId"])
              .update({"lastTime": date, "totalUnread": totalUnread});
        } else {
          // not exist on friend DB
          await users
              .doc(argument["friendEmail"])
              .collection("chats")
              .doc(argument["chatId"])
              .set({
            "connection": email,
            "lastTime": date,
            "totalUnread": 1,
          });
        }
      } catch (e) {
        if (e is FirebaseException && e.code == 'not-found') {
          debugPrint('Error: Document not found.');
          // Handle the document not found error here
        } else {
          // Handle other exceptions or errors
          debugPrint('Error: $e');
        }
      }
    }
  }

  // for chat page
  Stream<QuerySnapshot<Map<String, dynamic>>> chatsStream(String email) {
    return firestore
        .collection('users')
        .doc(email)
        .collection("chats")
        .orderBy("lastTime", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> chatsFriendStream(
      String email) {
    return firestore.collection('users').doc(email).snapshots();
  }

  void goToChatRoom(String chatId, String email, String friendEmail) async {
    CollectionReference chats = firestore.collection('chats');
    CollectionReference users = firestore.collection('users');

    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chats")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: email)
        .get();

    // ignore: avoid_function_literals_in_foreach_calls
    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chatId)
          .collection("chats")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(email)
        .collection("chats")
        .doc(chatId)
        .update({"totalUnread": 0});

    Get.toNamed(
      AppRoutes.chatRooms,
      arguments: {
        "chatId": chatId,
        "friendEmail": friendEmail,
      },
    );
  }
}
