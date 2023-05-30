import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger_app/app/data/model/users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_routes.dart';

class AuthenticationController extends GetxController {
  var isLogin = false.obs;

  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;
  UserCredential? userCredential;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var userModel = UsersModel().obs;

  Future<void> handleSignIn() async {
    try {
      await googleSignIn.signOut();
      await googleSignIn.signIn().then((value) => user = value);

      final isSignIn = await googleSignIn.isSignedIn();

      if (isSignIn) {
        if (kDebugMode) {
          print(user);
          print("Berhasil Login");
        }

        final googleAuth = await user!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        SharedPreferences pref = await SharedPreferences.getInstance();

        await pref.setString('login', googleAuth.accessToken!);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        if (kDebugMode) {
          print(userCredential);
        }

        CollectionReference collectionReference = firestore.collection("users");
        DocumentSnapshot checkUser =
            await collectionReference.doc(user!.email).get();

        if (!checkUser.exists) {
          await collectionReference.doc(user!.email).set({
            "uid": userCredential!.user!.uid,
            "name": user!.displayName,
            "keyName": user!.displayName!.substring(0, 1).toUpperCase(),
            "email": user!.email,
            "photoUrl": user!.photoUrl,
            "status": "",
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "creationTime":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "updateTime": DateTime.now().toIso8601String(),
          });

          collectionReference.doc(user!.email).collection("chats");
        } else {
          await collectionReference.doc(user!.email).update({
            "lastSignInTime":
                userCredential!.user!.metadata.lastSignInTime!.toIso8601String()
          });
        }
        final currentUser = await collectionReference.doc(user!.email).get();
        final currentUserData = currentUser.data() as Map<String, dynamic>;

        userModel(UsersModel.fromJson(currentUserData));
        userModel.refresh();

        final listChats = await collectionReference
            .doc(user!.email)
            .collection("chats")
            .get();
        if (listChats.docs.isNotEmpty) {
          List<ChatUser> dataListChats = [];
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              totalUnread: dataDocChat["totalUnread"],
            ));
          }

          userModel.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          userModel.update((user) {
            user!.chats = [];
          });
        }

        userModel.refresh();

        isLogin(true);
        Get.toNamed(AppRoutes.main);
      } else {
        if (kDebugMode) {
          print("Gagal Login");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> handleSignOut() async {
    try {
      await googleSignIn.signOut();
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.clear();
      Get.offNamed(AppRoutes.initial);
      if (kDebugMode) {
        print("Logout Berhasil");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void addNewConnection(String friendEmail) async {
    var chatId = "";
    String date = DateTime.now().toIso8601String();
    CollectionReference chats = firestore.collection("chats");
    CollectionReference users = firestore.collection("users");

    final documentChat = await users.doc(user!.email).collection("chats").get();

    if (documentChat.docs.isEmpty) {
      // user belum pernah chat dengan siapapun
      final checkConnection = await users
          .doc(user!.email)
          .collection("chats")
          .where("connection", isEqualTo: friendEmail)
          .get();

      if (checkConnection.docs.isNotEmpty) {
        // sudah pernah buat koneksi dengan friendEmail
        chatId = checkConnection.docs[0].id;
      } else {
        // belum pernah buat koneksi dengan friendEmail
        // buat koneksi baru
        final newChatDocument = await chats.add({
          "connection": [user!.email, friendEmail],
        });

        final newChatId = newChatDocument.id;

        await users.doc(user!.email).collection("chats").doc(newChatId).set({
          "connection": friendEmail,
          "lastTime": date,
          "totalUnread": 0,
        });

        chatId = newChatId;
      }
    } else {
      // user sudah pernah chat dengan seseorang
      final chatsDocuments = await chats.where("connection", whereIn: [
        [user!.email, friendEmail],
        [friendEmail, user!.email],
      ]).get();

      if (chatsDocuments.docs.isNotEmpty) {
        // terdapat chats

        if (chatsDocuments.docs.isNotEmpty) {
          // terdapat chats
          final chatData = chatsDocuments.docs[0];
          final chatDataId = chatData.id;
          final chatDataMap = chatData.data() as Map<String, dynamic>;

          if (chatDataMap.containsKey("lastTime")) {
            final lastTime = chatDataMap["lastTime"];

            await users
                .doc(user!.email)
                .collection("chats")
                .doc(chatDataId)
                .set({
              "connection": friendEmail,
              "lastTime": lastTime,
              "totalUnread": 0,
            });

            chatId = chatDataId;
          } else {
            // Handle the case when "lastTime" field is missing
            // For example, you can set a default value or show an error message
            final defaultLastTime = DateTime.now().toString();

            await users
                .doc(user!.email)
                .collection("chats")
                .doc(chatDataId)
                .set({
              "connection": friendEmail,
              "lastTime": defaultLastTime,
              "totalUnread": 0,
            });

            chatId = chatDataId;

            // Show an error message or perform any other required action
            debugPrint(
                "Warning: 'lastTime' field is missing in the chatData document.");
          }
        }
      }
    }

    final listChats = await users.doc(user!.email).collection("chats").get();

    List<ChatUser> dataListChats = listChats.docs.map((element) {
      var dataDocChat = element.data();
      var dataDocChatId = element.id;

      return ChatUser(
        chatId: dataDocChatId,
        connection: dataDocChat["connection"],
        lastTime: dataDocChat["lastTime"],
        totalUnread: dataDocChat["totalUnread"],
      );
    }).toList();

    userModel.update((user) {
      user!.chats = dataListChats.isNotEmpty ? dataListChats : [];
    });

    userModel.refresh();

    debugPrint(chatId);

    Get.toNamed(
      AppRoutes.chatRooms,
      arguments: {
        "chatId": chatId,
        "friendEmail": friendEmail,
      },
    );
  }
}
