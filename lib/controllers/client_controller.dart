import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_admin/models/user_model.dart';
import 'package:portfolio_admin/services/firebase_collections.dart';
import 'dart:typed_data';
import 'package:portfolio_admin/utilities/custom_snack_bar.dart';

class ClientController extends GetxController {
  final auth = FirebaseAuth.instance;
  static UserModel userModel = UserModel();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  RxBool isEditView = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  RxBool statusController = true.obs;

  RxList<UserModel> allClients = List<UserModel>.empty(growable: true).obs;

  Future<void> registerUser({
    required UserModel userModel,
    required String password,
    required Function() onSuccess,
    required Function() onError,
    required Uint8List imageData,
    required String fileName,
  }) async {
    try {
      UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(email: userModel.email, password: password);

      if (userCredential.user != null) {
        final imageUrl = await uploadProfile(data: imageData, fileName: fileName);

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
        CustomSnackBar.showSnackBar(message: "Client Registered Successfully");
      } else {
        debugPrint("User empty!");
      }
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError();
      CustomSnackBar.showSnackBar(message: e.toString(), color: Colors.red);
      debugPrint(e.toString());
    }
  }

  Future<void> updateClientData({
    required UserModel userModel,
    Uint8List? imageData,
    String? fileName,
  }) async {
    String updatedName = nameController.text;
    String updatedPhone = phoneController.text;
    String updatedDesignation = designationController.text;
    String updatedCompany = companyController.text;
    bool updatedStatus = statusController.value;

    Map<String, dynamic> updatedFields;

    if (imageData != null) {
      try {
        final imageUrl = await uploadProfile(data: imageData, fileName: fileName!);

        updatedFields = {
          'name': updatedName,
          'phone': updatedPhone,
          'designation': updatedDesignation,
          'company': updatedCompany,
          'isActive': updatedStatus,
          'profilePicture': imageUrl,
        };

        await FbCollections.users.doc(userModel.uid).update(updatedFields);

        int index = allClients.indexWhere((client) => client.uid == userModel.uid);

        allClients[index] = allClients[index].copyWith(
          name: updatedName,
          phone: updatedPhone,
          designation: updatedDesignation,
          company: updatedCompany,
          status: updatedStatus,
          profilePicture: imageUrl,
        );

        Get.forceAppUpdate();
        CustomSnackBar.showSnackBar(message: "Client Details Updated Successfully");
        debugPrint('Client data updated successfully.');
      } catch (e) {
        CustomSnackBar.showSnackBar(message: "Error updating client data: $e", color: Colors.red);
        debugPrint("Error updating client data: $e");
      }
    } else {
      try {
        updatedFields = {
          'name': updatedName,
          'phone': updatedPhone,
          'designation': updatedDesignation,
          'company': updatedCompany,
          'isActive': updatedStatus,
          'profilePicture': userModel.profilePicture,
        };

        await FbCollections.users.doc(userModel.uid).update(updatedFields);

        int index = allClients.indexWhere((client) => client.uid == userModel.uid);

        allClients[index] = allClients[index].copyWith(
          name: updatedName,
          phone: updatedPhone,
          designation: updatedDesignation,
          company: updatedCompany,
          status: updatedStatus,
          profilePicture: userModel.profilePicture,
        );

        Get.forceAppUpdate();
        CustomSnackBar.showSnackBar(message: "Client Details Updated Successfully");
        debugPrint('Client data updated successfully.');
      } catch (e) {
        CustomSnackBar.showSnackBar(message: "Error updating client data: $e", color: Colors.red);
        debugPrint("Error updating client data: $e");
      }
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

  Future<void> getAllClients() async {
    QuerySnapshot querySnapshot = await FbCollections.users.get();

    if (querySnapshot.size > 0) {
      allClients.value = querySnapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
    }
  }
}
