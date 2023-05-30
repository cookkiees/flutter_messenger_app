import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchingController extends GetxController {
  late TextEditingController search;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    search = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    search.dispose();
    super.onClose();
  }

  var queryAwal = [].obs;
  var tempSearch = [].obs;

  void searchFriend(String data, String email) async {
    debugPrint("SEARCH : $data");

    if (data.isEmpty) {
      queryAwal.clear();
      tempSearch.clear();
    } else {
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);
      debugPrint(capitalized);

      if (queryAwal.isEmpty && data.length == 1) {
        CollectionReference users = firestore.collection("users");
        final keyNameResult = await users
            .where("keyName", isEqualTo: data.substring(0, 1).toUpperCase())
            .where("email", isNotEqualTo: email)
            .get();

        debugPrint("TOTAL DATA : ${keyNameResult.docs.length}");
        queryAwal.assignAll(keyNameResult.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
        debugPrint("QUERY RESULT : ");
        debugPrint("$queryAwal");
      }

      tempSearch.assignAll(queryAwal
          .where((element) => element["name"].startsWith(capitalized)));
    }

    queryAwal.refresh();
    tempSearch.refresh();
  }
}
