import 'dart:typed_data';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:portfolio_admin/controllers/projects_controller.dart';
import 'dart:html' as html;

import 'package:portfolio_admin/models/projects_model.dart';

class ProjectDetailsView extends StatefulWidget {
  final Function() onClose;
  final Function() onRegisterProject;
  final ProjectsModel projectsModel;

  const ProjectDetailsView(
      {super.key, required this.onClose, required this.onRegisterProject, required this.projectsModel});

  @override
  State<ProjectDetailsView> createState() => _ProjectDetailsViewState();
}

class _ProjectDetailsViewState extends State<ProjectDetailsView> {
  final projectsController = Get.find<ProjectsController>();

  final ScrollController horizontalScrollController = ScrollController();

  bool loading = false;

  List<Uint8List?> images = List.filled(22, null);
  List<String?> imageNames = List.filled(22, null);

  bool builtForAndroid = false;
  bool builtForIOS = false;

  bool mainImageDarkBG = true;
  bool secondaryImageDarkBG = true;
  bool thirdImageDarkBG = true;

  String? selectedPlatform;

  void updatePlatform(String? value) {
    setState(() {
      selectedPlatform = value;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    horizontalScrollController.jumpTo(horizontalScrollController.offset - details.primaryDelta!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black45, width: 1),
            ),
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (projectsController.isProjectEditView.value)
                          InkWell(
                            onTap: () {
                              setState(() {
                                loading = true;
                                projectsController.updateProject(
                                  projectsModel: widget.projectsModel,
                                  onSuccess: () {
                                    setState(() {
                                      loading = false;
                                      widget.onRegisterProject();
                                      clearValues();
                                    });
                                  },
                                  onError: () {
                                    setState(() {
                                      loading = false;
                                    });
                                  },
                                );
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 30),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black87,
                              ),
                              child: loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 4,
                                      ),
                                    )
                                  : const Text(
                                      "Update Project",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        Text(projectsController.isProjectEditView.value ? "Switch to View Mode" : "Switch to Edit Mode")
                            .marginOnly(right: 1),
                        Transform.scale(
                          scale: 0.7,
                          child: SizedBox(
                            child: Switch(
                              value: projectsController.isProjectEditView.value,
                              onChanged: (v) {
                                projectsController.isProjectEditView.value = v;
                                v == true ? assignProjectValues() : clearValues();
                              },
                              overlayColor: null,
                              activeColor: Colors.black87,
                              inactiveThumbColor: Colors.black87,
                              activeTrackColor: Colors.green,
                              inactiveTrackColor: Colors.transparent,
                              splashRadius: 0,
                            ).marginOnly(right: 30),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            projectsController.isProjectEditView.value = false;
                            widget.onClose();
                          },
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          child: const Icon(
                            Ionicons.close_circle_outline,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    appShowcase(widget.projectsModel)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget appShowcase(ProjectsModel projectModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        projectsController.isProjectEditView.value
                            ? TextField(
                                cursorColor: Colors.black87,
                                decoration: const InputDecoration(
                                  isCollapsed: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black54),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                ),
                                controller: projectsController.projectNameController,
                                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600, color: Colors.black),
                              )
                            : Text(
                                projectModel.projectName,
                                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, right: 100),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Client Name: ${projectModel.clientName}",
                                    style:
                                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                  Text(
                                    "Client Company: ${projectModel.clientCompany}",
                                    style:
                                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                  Text(
                                    "Client UID: ${projectModel.clientUID}",
                                    style:
                                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Client Name: ${projectModel.clientName}",
                                    style:
                                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                  Text(
                                    "Project Platform: ${projectModel.projectPlatform}",
                                    style:
                                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                  Text(
                                    "Project UID: ${projectModel.projectUID}",
                                    style:
                                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Project Completed: ${projectModel.projectIsCompleted ? "Completed" : "Incomplete"}",
                                    style:
                                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                  Text(
                                    "Project Status: ${projectModel.projectStatus}",
                                    style:
                                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                  Text(
                                    "Project Budget: ${projectModel.projectBudget.toString().isNotEmpty ? projectModel.projectBudget : "N/A"}",
                                    style:
                                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (projectModel.projectPlatform == 'Mobile')
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Built for",
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 6),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (projectModel.builtForAndroid)
                                        const Row(
                                          children: [
                                            Icon(
                                              Ionicons.logo_android,
                                              size: 22,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Android",
                                              style: TextStyle(fontSize: 12, color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      if (projectModel.builtForAndroid && projectModel.builtForApple)
                                        const SizedBox(width: 10),
                                      if (projectModel.builtForAndroid && projectModel.builtForApple)
                                        const VerticalDivider(
                                          thickness: 2,
                                        ),
                                      if (projectModel.builtForAndroid && projectModel.builtForApple)
                                        const SizedBox(width: 10),
                                      if (projectModel.builtForApple)
                                        const Row(
                                          children: [
                                            Icon(
                                              Ionicons.logo_apple,
                                              size: 22,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Apple",
                                              style: TextStyle(fontSize: 12, color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  projectModel.appIcon.isEmpty
                      ? Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              projectModel.projectName[0],
                              style: const TextStyle(
                                fontSize: 100,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade900.withValues(alpha: 0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Center(
                              child: Padding(
                                padding: projectModel.iconPadding ? const EdgeInsets.all(20) : EdgeInsets.zero,
                                child: Image.network(
                                  projectModel.appIcon,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 120),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Project Date",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 6),
                          projectsController.isProjectEditView.value
                              ? TextField(
                                  cursorColor: Colors.black87,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    constraints: BoxConstraints(maxWidth: 200),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black54),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  ),
                                  controller: projectsController.projectDateController,
                                  style: const TextStyle(fontSize: 18),
                                )
                              : Text(
                                  projectModel.projectDate,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    const VerticalDivider(
                      thickness: 1,
                    ),
                    const SizedBox(width: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Project Type",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 6),
                          projectsController.isProjectEditView.value
                              ? TextField(
                                  cursorColor: Colors.black87,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    constraints: BoxConstraints(maxWidth: 200),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black54),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  ),
                                  controller: projectsController.projectTypeController,
                                  style: const TextStyle(fontSize: 18),
                                )
                              : Text(
                                  projectModel.projectType,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    const VerticalDivider(thickness: 1),
                    const SizedBox(width: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Project Duration",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          projectsController.isProjectEditView.value
                              ? TextField(
                                  cursorColor: Colors.black87,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    constraints: BoxConstraints(maxWidth: 200),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black54),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  ),
                                  controller: projectsController.projectDurationController,
                                  style: const TextStyle(fontSize: 18),
                                )
                              : Text(
                                  projectModel.projectDuration,
                                  style: const TextStyle(fontSize: 18),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: projectsController.isProjectEditView.value
                        ? TextField(
                            cursorColor: Colors.black87,
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            ),
                            controller: projectsController.projectShortBioController,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            projectModel.projectShortBio,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About this app",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  projectsController.isProjectEditView.value
                      ? TextField(
                          cursorColor: Colors.black87,
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          ),
                          controller: projectsController.projectDescriptionController,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        )
                      : Text(
                          projectModel.projectDescription,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                ],
              ),
              const SizedBox(height: 80),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "App Preview",
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: projectModel.projectPlatform == 'Mobile'
                        ? mobileShowcase(projectModel)
                        : webShowcase(projectModel),
                  ),
                ],
              ),
              const SizedBox(height: 120),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Challenges Faced",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  projectsController.isProjectEditView.value
                      ? TextField(
                          cursorColor: Colors.black87,
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          ),
                          controller: projectsController.projectChallengesFacedController,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        )
                      : Text(
                          projectModel.projectChallengesFaced,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                ],
              ),
              const SizedBox(height: 80),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Results and Impact",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  projectsController.isProjectEditView.value
                      ? TextField(
                          cursorColor: Colors.black87,
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          ),
                          controller: projectsController.projectResultsAndImpactsController,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        )
                      : Text(
                          projectModel.projectResultsAndImpacts,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                ],
              ),
              const SizedBox(height: 80),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Client Review",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  projectsController.isProjectEditView.value
                      ? TextField(
                          cursorColor: Colors.black87,
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          ),
                          controller: projectsController.projectClientReviewController,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        )
                      : Text(
                          projectModel.clientReview.toString().isNotEmpty
                              ? projectModel.clientReview
                              : 'Not reviewed yet!.',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget webShowcase(ProjectsModel projectModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: horizontalScrollController,
      child: GestureDetector(
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (projectModel.mainImage.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.mainImage),
            if (projectModel.secondImage.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.secondImage),
            if (projectModel.thirdImage.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.thirdImage),
            if (projectModel.extraImage1.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage1),
            if (projectModel.extraImage2.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage2),
            if (projectModel.extraImage3.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage3),
            if (projectModel.extraImage4.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage4),
            if (projectModel.extraImage5.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage5),
            if (projectModel.extraImage6.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage6),
            if (projectModel.extraImage7.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage7),
            if (projectModel.extraImage8.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage8),
            if (projectModel.extraImage9.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage9),
            if (projectModel.extraImage10.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage10),
            if (projectModel.extraImage11.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage11),
            if (projectModel.extraImage12.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage12),
            if (projectModel.extraImage13.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage13),
            if (projectModel.extraImage14.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage14),
            if (projectModel.extraImage15.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage15),
            if (projectModel.extraImage16.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage16),
            if (projectModel.extraImage17.isNotEmpty)
              webAppPreview(darkImageBg: projectModel.darkMainImageBG, image: projectModel.extraImage17),
          ],
        ),
      ),
    );
  }

  Widget mobileShowcase(ProjectsModel projectModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: horizontalScrollController,
      child: GestureDetector(
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (projectModel.mainImage.isNotEmpty) mobileAppPreview(mainImage: projectModel.mainImage),
            if (projectModel.secondImage.isNotEmpty) mobileAppPreview(mainImage: projectModel.secondImage),
            if (projectModel.thirdImage.isNotEmpty) mobileAppPreview(mainImage: projectModel.thirdImage),
            if (projectModel.extraImage1.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage1),
            if (projectModel.extraImage2.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage2),
            if (projectModel.extraImage3.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage3),
            if (projectModel.extraImage4.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage4),
            if (projectModel.extraImage5.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage5),
            if (projectModel.extraImage6.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage6),
            if (projectModel.extraImage7.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage7),
            if (projectModel.extraImage8.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage8),
            if (projectModel.extraImage9.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage9),
            if (projectModel.extraImage10.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage10),
            if (projectModel.extraImage11.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage11),
            if (projectModel.extraImage12.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage12),
            if (projectModel.extraImage13.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage13),
            if (projectModel.extraImage14.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage14),
            if (projectModel.extraImage15.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage15),
            if (projectModel.extraImage16.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage16),
            if (projectModel.extraImage17.isNotEmpty) mobileAppPreview(mainImage: projectModel.extraImage17),
          ],
        ),
      ),
    );
  }

  Widget webAppPreview({required bool darkImageBg, required String image}) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(right: 50),
      child: DeviceFrame(
        orientation: Orientation.landscape,
        device: Devices.ios.iPad12InchesGen4,
        screen: Container(
          color: darkImageBg ? Colors.black : Colors.white,
          child: Image.network(
            image,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topLeft,
          ),
        ),
      ),
    );
  }

  Widget mobileAppPreview({required String mainImage}) {
    return Container(
      margin: const EdgeInsets.only(right: 80),
      height: MediaQuery.of(context).size.height * .45,
      child: DeviceFrame(
        device: Devices.ios.iPhone13ProMax,
        screen: Container(
          color: Colors.white,
          child: Image.network(
            mainImage,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topLeft,
          ),
        ),
      ),
    );
  }

  String imageTextPlaceHolders(int index) {
    String imageTitle = '';

    switch (index) {
      case 0:
        imageTitle = 'Select App Icon';
      case 1:
        imageTitle = 'Select Main Image';
      case 2:
        imageTitle = 'Select Secondary Image';
      case 3:
        imageTitle = 'Select Third Image';
      case 4:
        imageTitle = 'Select Extra Image 1';
      case 5:
        imageTitle = 'Select Extra Image 2';
      case 6:
        imageTitle = 'Select Extra Image 3';
      case 7:
        imageTitle = 'Select Extra Image 4';
      case 8:
        imageTitle = 'Select Extra Image 5';
      case 9:
        imageTitle = 'Select Extra Image 6';
      case 10:
        imageTitle = 'Select Extra Image 7';
      case 11:
        imageTitle = 'Select Extra Image 8';
      case 12:
        imageTitle = 'Select Extra Image 9';
      case 13:
        imageTitle = 'Select Extra Image 10';
      case 14:
        imageTitle = 'Select Extra Image 11';
      case 15:
        imageTitle = 'Select Extra Image 12';
      case 16:
        imageTitle = 'Select Extra Image 13';
      case 17:
        imageTitle = 'Select Extra Image 14';
      case 18:
        imageTitle = 'Select Extra Image 15';
      case 19:
        imageTitle = 'Select Extra Image 16';
      case 20:
        imageTitle = 'Select Extra Image 17';
      case 21:
        imageTitle = 'Select Mobile View';
    }
    return imageTitle;
  }

  Future<void> selectImage(int index) async {
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files!;
      if (files.isEmpty) return;

      final file = files[0];
      final reader = html.FileReader();

      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((e) async {
        Uint8List data = reader.result as Uint8List;

        setState(() {
          images[index] = data;
          imageNames[index] = file.name;
        });
      });
    });

    uploadInput.click(); // Trigger the file picker
  }

  void assignProjectValues() {
    projectsController.projectNameController.text = widget.projectsModel.projectName;
    projectsController.projectDateController.text = widget.projectsModel.projectDate;
    projectsController.projectDurationController.text = widget.projectsModel.projectDuration;
    projectsController.projectBudgetController.text = widget.projectsModel.projectBudget;
    projectsController.projectStatusController.text = widget.projectsModel.projectStatus;
    projectsController.projectTypeController.text = widget.projectsModel.projectType;
    projectsController.projectShortBioController.text = widget.projectsModel.projectShortBio;
    projectsController.projectDescriptionController.text = widget.projectsModel.projectDescription;
    projectsController.projectChallengesFacedController.text = widget.projectsModel.projectChallengesFaced;
    projectsController.projectResultsAndImpactsController.text = widget.projectsModel.projectResultsAndImpacts;
    projectsController.projectClientReviewController.text = widget.projectsModel.clientReview;
  }

  void clearValues() {
    projectsController.projectNameController.clear();
    projectsController.projectDateController.clear();
    projectsController.projectDurationController.clear();
    projectsController.projectBudgetController.clear();
    projectsController.projectStatusController.clear();
    projectsController.projectTypeController.clear();
    projectsController.projectShortBioController.clear();
    projectsController.projectDescriptionController.clear();
    projectsController.projectChallengesFacedController.clear();
    projectsController.projectResultsAndImpactsController.clear();
    projectsController.projectClientReviewController.clear();
  }
}
