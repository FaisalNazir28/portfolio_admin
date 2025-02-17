import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio_admin/models/user_model.dart';
import 'package:portfolio_admin/services/firebase_collections.dart';

class AuthController {
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  static AdminModel adminModel = AdminModel();
  static String imager = "";

  Future<void> loginUser({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function() onError,
  }) async {
    try {
      final UserCredential credentials = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await getData(credentials.user!.uid);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError();
      debugPrint(e.toString());
    }
  }

  Future<void> registerUser(AdminModel userModel) async {
    UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(email: 'dummy@123.com', password: '123456789');

    if (userCredential.user != null) {
      var userID = auth.currentUser!.uid;
      FbCollections.users.doc(userID).set(userModel.toJson());
    } else {
      debugPrint("User not created!");
    }
  }

  Future<void> getData(String uid) async {
    await FbCollections.users.doc(uid).get().then((DocumentSnapshot ds) {
      adminModel = AdminModel.fromJson(ds.data() as Map<String, dynamic>);
    }, onError: (e) => debugPrint("Error fetching Data: $e"));
  }

  Future<void> getImageUrl() async {
    try {
      // final ref = storage.ref().child('companyLogo').child('pieas.jpg');
      final ref = storage.ref().child('projectShowcase').child('restofe').child('restofe3.png');
      final url = await ref.getDownloadURL();
      imager = url;
      print("URl===>>> $imager");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void logOutUser() async {
    await auth.signOut();
    adminModel = AdminModel();
  }

  bool userState() {
    if (adminModel.email.isNotEmpty && adminModel.isAdmin == true) {
      return true;
    } else {
      return false;
    }
  }
}
