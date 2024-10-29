import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:portfolio_admin/models/messages_model.dart';
import 'package:portfolio_admin/services/firebase_collections.dart';

class MessagesController extends GetxController {
  List<MessagesModel> allMessages = List<MessagesModel>.empty(growable: true).obs;

  Future<void> getAllMessages() async {
    QuerySnapshot querySnapshot = await FbCollections.contactMessages.get();

    if (querySnapshot.size > 0) {
      allMessages = querySnapshot.docs.map((doc) => MessagesModel.fromJson(doc.data())).toList();
    }
  }
}
