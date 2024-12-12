import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portfolio_admin/models/projects_model.dart';
import 'package:portfolio_admin/services/firebase_collections.dart';

class ProjectsController extends GetxController {
  var allProjects = <ProjectsModel>[].obs;
  var webProjects = <ProjectsModel>[].obs;
  var mobileProjects = <ProjectsModel>[].obs;
  var hybridProjects = <ProjectsModel>[].obs;
  var portfolioWebsites = <ProjectsModel>[].obs;
  var fullPagerWebsites = <ProjectsModel>[].obs;

  var sortedWebProjects = <ProjectsModel>[].obs;
  var sortedMobileProjects = <ProjectsModel>[].obs;
  var sortedHybridProjects = <ProjectsModel>[].obs;

  RxInt selectedOption = 0.obs;
  RxInt webProjectsToShow = 5.obs;
  RxInt mobileProjectsToShow = 5.obs;
  RxInt hybridProjectsToShow = 5.obs;

  Future<void> getAllProjects() async {
    allProjects.value = await _getProjects();
  }

  Future<void> getWebProjects() async {
    webProjects.value = (await _getProjects()).where((e) => e.projectPlatform == "Web").toList();
  }

  Future<void> getMobileProjects() async {
    mobileProjects.value = (await _getProjects()).where((e) => e.projectPlatform == "Mobile").toList();
  }

  Future<void> getHybridProjects() async {
    hybridProjects.value = (await _getProjects()).where((e) => e.projectPlatform == "Hybrid").toList();
  }

  Future<void> getFilteredSites() async {
    portfolioWebsites.value = (await _getProjects())
        .where((e) =>
            e.projectPlatform == 'Web' &&
            (e.projectType == "Portfolio Development" || e.projectType == "Portfolio Website"))
        .toList();
    fullPagerWebsites.value = (await _getProjects())
        .where((e) =>
            e.projectPlatform == 'Web' &&
            (e.projectType != "Portfolio Development" && e.projectType != "Portfolio Website"))
        .toList();
  }

  Future<void> getSortedProjects() async {
    Future.delayed(const Duration(seconds: 5)).then((e) {
      sortedWebProjects.value = List.from(webProjects);
      sortedMobileProjects.value = List.from(mobileProjects);
      sortedWebProjects.sort((a, b) => int.parse(a.projectIndex).compareTo(int.parse(b.projectIndex)));
      sortedMobileProjects.sort((a, b) => a.projectIndex.compareTo(b.projectIndex));
    });
  }

  static Future<List<ProjectsModel>> _getProjects() async {
    QuerySnapshot querySnapshot = await FbCollections.projects.get();
    if (querySnapshot.size > 0) {
      return querySnapshot.docs.map((doc) => ProjectsModel.fromJson(doc.data())).toList();
    }
    return [];
  }

  static Future<void> updateCount(String projectID, String field, int oldValue) async {
    try {
      int newValue = oldValue + 1;
      await FbCollections.projects.doc(projectID).update({field: newValue});
    } catch (e) {
      debugPrint("Error Updating Document: $e");
    }
  }

  static void updateLikesCount(String projectID, int oldValue) {
    updateCount(projectID, "likesCount", oldValue);
  }

  static void updateStarsCount(String projectID, int oldValue) {
    updateCount(projectID, "starsCount", oldValue);
  }

  static void updateLoveCount(String projectID, int oldValue) {
    updateCount(projectID, "loveCount", oldValue);
  }

  Future<void> getDownloadUrl() async {
    try {
      // path of the image
      String imagePath = 'projectShowcase/my_portfolio/clientportal.png';
      // Reference to the image in Firebase Storage
      Reference storageReference = FirebaseStorage.instance.ref().child(imagePath);

      // Get the download URL
      String downloadUrl = await storageReference.getDownloadURL();

      debugPrint("Downloadable URL==> $downloadUrl");
      // return downloadUrl; // Return the download URL
    } catch (e) {
      debugPrint('Error fetching download URL: $e');
      // return ''; // Return an empty string or handle error as needed
    }
  }
}
