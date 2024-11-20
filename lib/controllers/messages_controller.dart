import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portfolio_admin/models/messages_model.dart';
import 'package:portfolio_admin/services/firebase_collections.dart';

class MessagesController extends GetxController {
  RxList<MessagesModel> allMessages = List<MessagesModel>.empty(growable: true).obs;

  Future<void> getAllMessages() async {
    QuerySnapshot querySnapshot = await FbCollections.contactMessages.get();

    if (querySnapshot.size > 0) {
      allMessages.value = querySnapshot.docs.map((doc) => MessagesModel.fromJson(doc.data())).toList();
    }
    allMessages.sort((a, b) => b.time.compareTo(a.time));
    Future.delayed(const Duration(seconds: 30), () {
      getAllMessages();
    });
  }

  Future<void> markAsRead({required String messageUid}) async {
    try {
      DocumentReference messageRef = FbCollections.contactMessages.doc(messageUid);

      await messageRef.update({
        'status': 'read',
      });

      int index = allMessages.indexWhere((message) => message.uid == messageUid);
      allMessages[index].status = 'read'; // Update the status in the local list
      Get.forceAppUpdate();
    } catch (e) {
      debugPrint("Error marking message as read: $e");
    }
  }
}
