import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio_admin/models/user_model.dart';
import 'package:portfolio_admin/services/firebase_collections.dart';

class ClientController {
  final auth = FirebaseAuth.instance;
  static UserModel userModel = UserModel();

  Future<void> registerUser(UserModel userModel) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: 'dummy@123.com', password: '123456789');

    if (userCredential.user != null) {
      var userID = auth.currentUser!.uid;
      FbCollections.users.doc(userID).set(userModel.toJson());
    } else {
      debugPrint("User not created!");
    }
  }

  Future<List<UserModel>> getAllClients() async {
    List<UserModel> allClients = List<UserModel>.empty(growable: true);
    QuerySnapshot querySnapshot = await FbCollections.users.get();

    if (querySnapshot.size > 0) {
      allClients = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    }
    return allClients;
  }
}
