import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:portfolio_admin/controllers/projects_controller.dart';
import 'dart:html' as html;

import 'package:portfolio_admin/models/projects_model.dart';

class AddNewProject extends StatefulWidget {
  final Function() onClose;
  final Function() onRegisterProject;

  const AddNewProject({super.key, required this.onClose, required this.onRegisterProject});

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  final _formKey = GlobalKey<FormState>();

  final projectsController = Get.find<ProjectsController>();

  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectDateController = TextEditingController();
  final TextEditingController _projectDurationController = TextEditingController();
  final TextEditingController _projectBudgetController = TextEditingController();
  final TextEditingController _projectStatusController = TextEditingController();
  final TextEditingController _projectTypeController = TextEditingController();
  final TextEditingController _projectShortBioController = TextEditingController();
  final TextEditingController _projectDescriptionController = TextEditingController();
  final TextEditingController _projectChallengesFacedController = TextEditingController();
  final TextEditingController _projectResultsAndImpactsController = TextEditingController();
  final TextEditingController _projectClientReviewController = TextEditingController();

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Register New Project",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () => widget.onClose(),
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        child: const Icon(
                          Ionicons.close_circle_outline,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.black87,
                                      controller: _projectNameController,
                                      decoration: InputDecoration(
                                        labelText: 'Project Name',
                                        labelStyle: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black54,
                                        ),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Project Name is missing';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.black87,
                                      controller: _projectDateController,
                                      decoration: InputDecoration(
                                        labelText: 'Project Date',
                                        labelStyle: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black54,
                                        ),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Project Date is missing';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.black87,
                                      controller: _projectDurationController,
                                      decoration: InputDecoration(
                                        labelText: 'Project Duration',
                                        labelStyle: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black54,
                                        ),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Project Duration is missing';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        cursorColor: Colors.black87,
                                        controller: _projectBudgetController,
                                        decoration: InputDecoration(
                                          labelText: 'Project Budget',
                                          labelStyle: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black54,
                                          ),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Project Budget is missing';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black54, width: 1),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Project Platform: ',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Radio<String>(
                                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                                              activeColor: Colors.black87,
                                              value: 'Web',
                                              groupValue: selectedPlatform,
                                              onChanged: updatePlatform,
                                            ),
                                            const Text(
                                              'Web',
                                              style: TextStyle(
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Radio<String>(
                                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                                              activeColor: Colors.black87,
                                              value: 'Mobile',
                                              groupValue: selectedPlatform,
                                              onChanged: updatePlatform,
                                            ),
                                            const Text(
                                              'Mobile',
                                              style: TextStyle(
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Radio<String>(
                                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                                              activeColor: Colors.black87,
                                              value: 'Hybrid',
                                              groupValue: selectedPlatform,
                                              onChanged: updatePlatform,
                                            ),
                                            const Text(
                                              'Hybrid',
                                              style: TextStyle(
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        cursorColor: Colors.black87,
                                        controller: _projectStatusController,
                                        decoration: InputDecoration(
                                          labelText: 'Project Status',
                                          labelStyle: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black54,
                                          ),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Project Status is missing';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        cursorColor: Colors.black87,
                                        controller: _projectTypeController,
                                        decoration: InputDecoration(
                                          labelText: 'Project Type',
                                          labelStyle: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black54,
                                          ),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Project Type is missing';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black54, width: 1),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Built For: ',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  builtForAndroid = !builtForAndroid;
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: builtForAndroid ? Colors.black87 : Colors.transparent,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: builtForAndroid ? Colors.black87 : Colors.grey)),
                                                padding: const EdgeInsets.all(2),
                                                child: Icon(
                                                  Ionicons.checkmark,
                                                  color: builtForAndroid ? Colors.white : Colors.transparent,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Android',
                                              style: TextStyle(
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  builtForIOS = !builtForIOS;
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: builtForIOS ? Colors.black87 : Colors.transparent,
                                                    shape: BoxShape.circle,
                                                    border:
                                                        Border.all(color: builtForIOS ? Colors.black87 : Colors.grey)),
                                                padding: const EdgeInsets.all(2),
                                                child: Icon(
                                                  Ionicons.checkmark,
                                                  color: builtForIOS ? Colors.white : Colors.transparent,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'iOS',
                                              style: TextStyle(
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _projectShortBioController,
                                decoration: InputDecoration(
                                  labelText: 'Project Short Bio',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Project Short Bio is missing';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _projectDescriptionController,
                                decoration: InputDecoration(
                                  labelText: 'Project Description',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Project Description is missing';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _projectChallengesFacedController,
                                decoration: InputDecoration(
                                  labelText: 'Project Challenges Faced',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _projectResultsAndImpactsController,
                                decoration: InputDecoration(
                                  labelText: 'Project Results & Impacts',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _projectClientReviewController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Client Review',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 120),
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 0.63,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black87, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 80),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text('Main Image BG:'),
                                            const SizedBox(width: 15),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  mainImageDarkBG = true;
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.black87,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.black26)),
                                                padding: const EdgeInsets.all(2),
                                                child: Icon(
                                                  Ionicons.checkmark,
                                                  color: mainImageDarkBG ? Colors.white : Colors.transparent,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  mainImageDarkBG = false;
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.black87)),
                                                padding: const EdgeInsets.all(2),
                                                child: Icon(
                                                  Ionicons.checkmark,
                                                  color: !mainImageDarkBG ? Colors.black87 : Colors.transparent,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text('Secondary Image BG:'),
                                            const SizedBox(width: 15),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  secondaryImageDarkBG = true;
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.black87,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.black26)),
                                                padding: const EdgeInsets.all(2),
                                                child: Icon(
                                                  Ionicons.checkmark,
                                                  color: secondaryImageDarkBG ? Colors.white : Colors.transparent,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  secondaryImageDarkBG = false;
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.black87)),
                                                padding: const EdgeInsets.all(2),
                                                child: Icon(
                                                  Ionicons.checkmark,
                                                  color: !secondaryImageDarkBG ? Colors.black87 : Colors.transparent,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text('Third Image BG:'),
                                            const SizedBox(width: 15),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  thirdImageDarkBG = true;
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.black87,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.black26)),
                                                padding: const EdgeInsets.all(2),
                                                child: Icon(
                                                  Ionicons.checkmark,
                                                  color: thirdImageDarkBG ? Colors.white : Colors.transparent,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  thirdImageDarkBG = false;
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.black87)),
                                                padding: const EdgeInsets.all(2),
                                                child: Icon(
                                                  Ionicons.checkmark,
                                                  color: !thirdImageDarkBG ? Colors.black87 : Colors.transparent,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 30,
                                    runSpacing: 30,
                                    children: List.generate(images.length, (index) {
                                      return InkWell(
                                        onTap: () async {
                                          await selectImage(index);
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 200,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black87),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: images[index] == null
                                                  ? Center(child: Text(imageTextPlaceHolders(index)))
                                                  : Image.memory(images[index]!),
                                            ),
                                            if (images[index] != null)
                                              Positioned(
                                                top: 5,
                                                right: 15,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        imageNames[index]!,
                                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            images[index] = null;
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Ionicons.close_outline,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: loading
                            ? () {}
                            : () async {
                                ProjectsModel projectModel = ProjectsModel(
                                  projectName: _projectNameController.text,
                                  projectPlatform: selectedPlatform,
                                  projectShortBio: _projectShortBioController.text,
                                  projectDescription: _projectDescriptionController.text,
                                  projectDate: _projectDateController.text,
                                  projectType: _projectTypeController.text,
                                  projectDuration: _projectDurationController.text,
                                  unPaidAmount: _projectBudgetController.text,
                                  projectBudget: _projectBudgetController.text,
                                  projectStatus: _projectStatusController.text,
                                  darkMainImageBG: mainImageDarkBG,
                                  darkSecondImageBG: secondaryImageDarkBG,
                                  darkThirdImageBG: thirdImageDarkBG,
                                  builtForAndroid: builtForAndroid,
                                  builtForApple: builtForIOS,
                                );
                                if (_formKey.currentState!.validate() && selectedPlatform != null) {
                                  setState(() {
                                    loading = true;
                                    projectsController.registerNewProject(
                                      projectModel: projectModel,
                                      images: images,
                                      imageNames: imageNames,
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
                                }
                              },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
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
                                  "Add Project",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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

  void clearValues() {
    _projectNameController.clear();
    _projectDateController.clear();
    _projectDurationController.clear();
    _projectBudgetController.clear();
    _projectStatusController.clear();
    _projectTypeController.clear();
    _projectShortBioController.clear();
    _projectDescriptionController.clear();
    _projectChallengesFacedController.clear();
    _projectResultsAndImpactsController.clear();
    _projectClientReviewController.clear();
  }
}
