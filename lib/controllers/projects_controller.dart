import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_admin/models/projects_model.dart';
import 'package:portfolio_admin/models/user_model.dart';
import 'package:portfolio_admin/services/firebase_collections.dart';
import 'package:portfolio_admin/utilities/custom_snack_bar.dart';
import 'package:uuid/uuid.dart';

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

  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectDateController = TextEditingController();
  final TextEditingController projectDurationController = TextEditingController();
  final TextEditingController projectBudgetController = TextEditingController();
  final TextEditingController projectStatusController = TextEditingController();
  final TextEditingController projectTypeController = TextEditingController();
  final TextEditingController projectShortBioController = TextEditingController();
  final TextEditingController projectDescriptionController = TextEditingController();
  final TextEditingController projectChallengesFacedController = TextEditingController();
  final TextEditingController projectResultsAndImpactsController = TextEditingController();
  final TextEditingController projectClientReviewController = TextEditingController();

  RxBool isProjectEditView = false.obs;

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

  // Function to get projects by client name
  List<ProjectsModel> getProjectsByClient(String clientUID) {
    return allProjects
        .where((project) => project.clientUID.toString().toLowerCase() == clientUID.toLowerCase())
        .toList();
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

  static Future<void> bindProjectWithClient({
    required String projectID,
    required AdminModel clientDetails,
    required Function onSuccess,
  }) async {
    try {
      await FbCollections.projects.doc(projectID).update({
        'clientUID': clientDetails.uid,
        'clientName': clientDetails.name,
        'clientCompany': clientDetails.company,
      });
      CustomSnackBar.showSnackBar(message: "Project Assigned Successfully");
      onSuccess();
    } catch (e) {
      debugPrint("Error Updating Document: $e");
    }
  }

  static Future<void> unBindProjectFromClient({
    required String projectID,
    required Function onSuccess,
  }) async {
    try {
      await FbCollections.projects.doc(projectID).update({'clientUID': ''});
      CustomSnackBar.showSnackBar(message: "Project UnBind Successfully");
      onSuccess();
    } catch (e) {
      debugPrint("Error Updating Document: $e");
    }
  }

  Future<void> registerNewProject({
    required ProjectsModel projectModel,
    required Function() onSuccess,
    required Function() onError,
    required List<Uint8List?> images,
    required List<String?> imageNames,
  }) async {
    String folderName = projectModel.projectName.toString().toLowerCase().replaceAll(' ', '_');

    try {
      String appIcon = '';
      String mainImage = '';
      String secondImage = '';
      String thirdImage = '';
      String extraImage1 = '';
      String extraImage2 = '';
      String extraImage3 = '';
      String extraImage4 = '';
      String extraImage5 = '';
      String extraImage6 = '';
      String extraImage7 = '';
      String extraImage8 = '';
      String extraImage9 = '';
      String extraImage10 = '';
      String extraImage11 = '';
      String extraImage12 = '';
      String extraImage13 = '';
      String extraImage14 = '';
      String extraImage15 = '';
      String extraImage16 = '';
      String extraImage17 = '';
      String mobileView = '';

      if (images[0] != null) {
        appIcon = await uploadProfile(data: images[0]!, fileName: imageNames[0]!, folderName: folderName);
      }
      if (images[1] != null) {
        mainImage = await uploadProfile(data: images[1]!, fileName: imageNames[1]!, folderName: folderName);
      }
      if (images[2] != null) {
        secondImage = await uploadProfile(data: images[2]!, fileName: imageNames[2]!, folderName: folderName);
      }
      if (images[3] != null) {
        thirdImage = await uploadProfile(data: images[3]!, fileName: imageNames[3]!, folderName: folderName);
      }
      if (images[4] != null) {
        extraImage1 = await uploadProfile(data: images[4]!, fileName: imageNames[4]!, folderName: folderName);
      }
      if (images[5] != null) {
        extraImage2 = await uploadProfile(data: images[5]!, fileName: imageNames[5]!, folderName: folderName);
      }
      if (images[6] != null) {
        extraImage3 = await uploadProfile(data: images[6]!, fileName: imageNames[6]!, folderName: folderName);
      }
      if (images[7] != null) {
        extraImage4 = await uploadProfile(data: images[7]!, fileName: imageNames[7]!, folderName: folderName);
      }
      if (images[8] != null) {
        extraImage5 = await uploadProfile(data: images[8]!, fileName: imageNames[8]!, folderName: folderName);
      }
      if (images[9] != null) {
        extraImage6 = await uploadProfile(data: images[9]!, fileName: imageNames[9]!, folderName: folderName);
      }
      if (images[10] != null) {
        extraImage7 = await uploadProfile(data: images[10]!, fileName: imageNames[10]!, folderName: folderName);
      }
      if (images[11] != null) {
        extraImage8 = await uploadProfile(data: images[11]!, fileName: imageNames[11]!, folderName: folderName);
      }
      if (images[12] != null) {
        extraImage9 = await uploadProfile(data: images[12]!, fileName: imageNames[12]!, folderName: folderName);
      }
      if (images[13] != null) {
        extraImage10 = await uploadProfile(data: images[13]!, fileName: imageNames[13]!, folderName: folderName);
      }
      if (images[14] != null) {
        extraImage11 = await uploadProfile(data: images[14]!, fileName: imageNames[14]!, folderName: folderName);
      }
      if (images[15] != null) {
        extraImage12 = await uploadProfile(data: images[15]!, fileName: imageNames[15]!, folderName: folderName);
      }
      if (images[16] != null) {
        extraImage13 = await uploadProfile(data: images[16]!, fileName: imageNames[16]!, folderName: folderName);
      }
      if (images[17] != null) {
        extraImage14 = await uploadProfile(data: images[17]!, fileName: imageNames[17]!, folderName: folderName);
      }
      if (images[18] != null) {
        extraImage15 = await uploadProfile(data: images[18]!, fileName: imageNames[18]!, folderName: folderName);
      }
      if (images[19] != null) {
        extraImage16 = await uploadProfile(data: images[19]!, fileName: imageNames[19]!, folderName: folderName);
      }
      if (images[20] != null) {
        extraImage17 = await uploadProfile(data: images[20]!, fileName: imageNames[20]!, folderName: folderName);
      }
      if (images[21] != null) {
        mobileView = await uploadProfile(data: images[21]!, fileName: imageNames[21]!, folderName: folderName);
      }

      var lastProjectIndex = await getHighestProjectIndex();

      var uuid = const Uuid();
      String projectUID = uuid.v4();

      ProjectsModel project = ProjectsModel(
        projectIndex: (lastProjectIndex + 1).toString(),
        clientUID: "",
        projectUID: projectUID,
        clientName: "",
        clientCompany: "",
        projectName: projectModel.projectName,
        projectPlatform: projectModel.projectPlatform,
        projectShortBio: projectModel.projectShortBio,
        projectDescription: projectModel.projectDescription,
        projectDate: projectModel.projectDate,
        projectType: projectModel.projectType,
        paidAmount: projectModel.paidAmount,
        unPaidAmount: projectModel.unPaidAmount,
        discountedAmount: projectModel.discountedAmount,
        projectDuration: projectModel.projectDuration,
        projectBudget: projectModel.projectBudget,
        projectChallengesFaced: "",
        projectResultsAndImpacts: "",
        projectStatus: projectModel.projectStatus,
        darkMainImageBG: projectModel.darkMainImageBG,
        darkSecondImageBG: projectModel.darkSecondImageBG,
        darkThirdImageBG: projectModel.darkThirdImageBG,
        mainImage: mainImage,
        secondImage: secondImage,
        thirdImage: thirdImage,
        extraImage1: extraImage1,
        extraImage2: extraImage2,
        extraImage3: extraImage3,
        extraImage4: extraImage4,
        extraImage5: extraImage5,
        extraImage6: extraImage6,
        extraImage7: extraImage7,
        extraImage8: extraImage8,
        extraImage9: extraImage9,
        extraImage10: extraImage10,
        extraImage11: extraImage11,
        extraImage12: extraImage12,
        extraImage13: extraImage13,
        extraImage14: extraImage14,
        extraImage15: extraImage15,
        extraImage16: extraImage16,
        extraImage17: extraImage17,
        mobileView: mobileView,
        likesCount: "0",
        starsCount: "0",
        loveCount: "0",
        appIcon: appIcon,
        iconPadding: appIcon.isEmpty ? true : false,
        appThemeColor: "",
        builtForAndroid: projectModel.builtForAndroid,
        builtForApple: projectModel.builtForApple,
        projectIsCompleted: false,
        clientReview: "",
      );

      FbCollections.projects.doc(projectUID).set(project.toJson());

      CustomSnackBar.showSnackBar(message: "Project Registered Successfully");
      onSuccess();
    } catch (e) {
      onError();
      CustomSnackBar.showSnackBar(message: e.toString(), color: Colors.red);
      debugPrint(e.toString());
    }
  }

  Future<void> updateProject({
    required ProjectsModel projectsModel,
    required Function() onSuccess,
    required Function() onError,
  }) async {
    final updatedProject = ProjectsModel(
      projectIndex: projectsModel.projectIndex,
      clientUID: projectsModel.clientUID,
      projectUID: projectsModel.projectUID,
      clientName: projectsModel.clientName,
      clientCompany: projectsModel.clientName,
      projectName: projectNameController.text,
      projectPlatform: projectsModel.projectPlatform,
      projectShortBio: projectShortBioController.text,
      projectDescription: projectDescriptionController.text,
      projectDate: projectDateController.text,
      projectType: projectTypeController.text,
      projectDuration: projectDurationController.text,
      paidAmount: projectsModel.paidAmount,
      unPaidAmount: projectsModel.unPaidAmount,
      discountedAmount: projectsModel.discountedAmount,
      projectBudget: projectBudgetController.text,
      projectChallengesFaced: projectChallengesFacedController.text,
      projectResultsAndImpacts: projectResultsAndImpactsController.text,
      projectStatus: projectStatusController.text,
      darkMainImageBG: projectsModel.darkMainImageBG,
      darkSecondImageBG: projectsModel.darkSecondImageBG,
      darkThirdImageBG: projectsModel.darkThirdImageBG,
      mainImage: projectsModel.mainImage,
      secondImage: projectsModel.secondImage,
      thirdImage: projectsModel.thirdImage,
      extraImage1: projectsModel.extraImage1,
      extraImage2: projectsModel.extraImage2,
      extraImage3: projectsModel.extraImage3,
      extraImage4: projectsModel.extraImage4,
      extraImage5: projectsModel.extraImage5,
      extraImage6: projectsModel.extraImage6,
      extraImage7: projectsModel.extraImage7,
      extraImage8: projectsModel.extraImage8,
      extraImage9: projectsModel.extraImage9,
      extraImage10: projectsModel.extraImage10,
      extraImage11: projectsModel.extraImage11,
      extraImage12: projectsModel.extraImage12,
      extraImage13: projectsModel.extraImage13,
      extraImage14: projectsModel.extraImage14,
      extraImage15: projectsModel.extraImage15,
      extraImage16: projectsModel.extraImage16,
      extraImage17: projectsModel.extraImage17,
      mobileView: projectsModel.mobileView,
      likesCount: projectsModel.likesCount,
      starsCount: projectsModel.starsCount,
      loveCount: projectsModel.loveCount,
      appIcon: projectsModel.appIcon,
      iconPadding: projectsModel.iconPadding,
      appThemeColor: projectsModel.appThemeColor,
      builtForAndroid: projectsModel.builtForAndroid,
      builtForApple: projectsModel.builtForApple,
      projectIsCompleted: projectsModel.projectIsCompleted,
      clientReview: projectClientReviewController.text,
    );

    try {
      await FbCollections.projects.doc(projectsModel.projectUID).update(updatedProject.toJson());

      int index = allProjects.indexWhere((project) => project.projectUID == projectsModel.projectUID);

      allProjects[index] = allProjects[index].copyWith(
        projectName: projectNameController.text,
        projectShortBio: projectShortBioController.text,
        projectDescription: projectDescriptionController.text,
        projectDate: projectDateController.text,
        projectType: projectTypeController.text,
        projectDuration: projectDurationController.text,
        projectBudget: projectBudgetController.text,
        projectChallengesFaced: projectChallengesFacedController.text,
        projectResultsAndImpacts: projectResultsAndImpactsController.text,
        projectStatus: projectStatusController.text,
        clientReview: projectClientReviewController.text,
      );

      Get.forceAppUpdate();
      CustomSnackBar.showSnackBar(message: "Project Details Updated Successfully");
      debugPrint('Project data updated successfully.');
      onSuccess();
    } catch (e) {
      onError();
      CustomSnackBar.showSnackBar(message: "Error updating project data: $e", color: Colors.red);
      debugPrint("Error updating project data: $e");
    }
  }

  Future<bool> deleteProject(String projectId) async {
    try {
      await FbCollections.projects.doc(projectId).delete();
      CustomSnackBar.showSnackBar(message: "Project Deleted Successfully");
      return true;
    } catch (e) {
      CustomSnackBar.showSnackBar(message: "Error Deleting Project: $e", color: Colors.red);
      return false;
    }
  }

  Future<String> uploadProfile({
    required Uint8List data,
    required String fileName,
    required String folderName,
  }) async {
    try {
      // Create a reference to the Firebase Storage location
      final storageRef = FirebaseStorage.instance.ref().child('projectShowcase/$folderName/$fileName');

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

  Future<int> getHighestProjectIndex() async {
    int highestProjectIndex = 0;
    try {
      var newProjects = List.from(allProjects);

      newProjects.sort((b, a) => int.parse(a.projectIndex).compareTo(int.parse(b.projectIndex)));

      highestProjectIndex = int.parse(newProjects[0].projectIndex);
      return highestProjectIndex;
    } catch (e) {
      debugPrint("Error fetching highest project index: $e");
    }
    return highestProjectIndex;
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
