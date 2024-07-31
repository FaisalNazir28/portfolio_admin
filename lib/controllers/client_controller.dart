import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio_admin/models/user_model.dart';
import 'package:portfolio_admin/services/firebase_collections.dart';
import 'dart:typed_data';

class ClientController {
  final auth = FirebaseAuth.instance;
  static UserModel userModel = UserModel();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> registerUser({
    required UserModel userModel,
    required String password,
    required Function() onSuccess,
    required Function() onError,
    required Uint8List imageData,
    required String fileName,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);

      if (userCredential.user != null) {
        final imageUrl =
            await uploadProfile(data: imageData, fileName: fileName);

        var userID = auth.currentUser!.uid;

        UserModel client = UserModel(
          uid: userID,
          email: userModel.email,
          name: userModel.name,
          phone: userModel.phone,
          profilePicture: imageUrl,
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

  Future<String> uploadProfile({
    required Uint8List data,
    required String fileName,
  }) async {
    try {
      // Create a reference to the Firebase Storage location
      final storageRef = _storage.ref().child('userProfiles/$fileName');

      // Upload the image data
      final uploadTask = storageRef.putData(data);

      final snapshot = await uploadTask;

      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      debugPrint('Upload failed: $error');
      rethrow;
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
