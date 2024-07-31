import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio_admin/models/user_model.dart';
import 'package:portfolio_admin/services/firebase_collections.dart';

class ClientController {
  final auth = FirebaseAuth.instance;
  static UserModel userModel = UserModel();

  Future<void> registerUser({
    required UserModel userModel,
    required String password,
    required Function() onSuccess,
    required Function() onError,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);

      if (userCredential.user != null) {
        var userID = auth.currentUser!.uid;
        UserModel client = UserModel(
          uid: userID,
          email: userModel.email,
          name: userModel.name,
          phone: userModel.phone,
          profilePicture: userModel.profilePicture,
          designation: userModel.designation,
          company: userModel.company,
          isActive: true,
          isAdmin: false,
        );
        FbCollections.users.doc(userID).set(client.toJson());
      } else {
        debugPrint("User empty!");
      }
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError();
      debugPrint(e.toString());
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
