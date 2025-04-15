import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_admin/models/projects_model.dart';

class DeleteProjectDialogBox extends StatelessWidget {
  final ProjectsModel projectsModel;
  final Function() onSuccess;
  DeleteProjectDialogBox({required this.onSuccess, required this.projectsModel, super.key});

  final RxBool areYouSureToDelete = false.obs;

  @override
  Widget build(BuildContext context) {
    areYouSureToDelete.value = false;
    return Obx(
      () {
        return Container(
          margin: const EdgeInsets.only(left: 50),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 6,
            backgroundColor: Colors.white,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: projectsModel.clientUID.toString().isEmpty ? Get.height * .5 : Get.height * .65,
              ),
              width: Get.width * 0.33,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.exclamationmark_triangle,
                    color: Colors.red.shade600,
                    size: 80,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Are you sure you want to delete this project?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "This action is permanent. Project cannot be recovered later!",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.red.shade600),
                  ),
                  const SizedBox(height: 35),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            projectsModel.projectPlatform == "Mobile" ? projectsModel.appIcon : projectsModel.mainImage,
                          ),
                          radius: 40,
                        ),
                        const SizedBox(width: 15),
                        const VerticalDivider(width: 5),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              projectsModel.projectName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${projectsModel.projectDate} - ${projectsModel.projectStatus}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${projectsModel.projectType} - ",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  projectsModel.projectPlatform,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (projectsModel.clientUID.toString().isNotEmpty)
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Divider(),
                          Text(
                            "Warning!",
                            style: TextStyle(color: Colors.red.shade600, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "This project is assigned to a client.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Client UID: ${projectsModel.clientUID}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Client Name: ${projectsModel.clientName}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Client Company: ${projectsModel.clientCompany}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Deleting this project will automatically unassign clients binded to it.\nProject will be lost and cannot be recovered. This action cannot be reverted!",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ).marginOnly(top: 35),
                    ),
                  const SizedBox(height: 35),
                  areYouSureToDelete.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Are you Sure? You want to delete this project?",
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                areYouSureToDelete.value = false;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black26,
                                ),
                                child: const Text(
                                  "No",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                onSuccess();
                                Get.back();
                                areYouSureToDelete.value = false;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red.shade600,
                                ),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                                areYouSureToDelete.value = false;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black26,
                                ),
                                child: const Text(
                                  "Dismiss",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: projectsModel.clientUID.toString().isEmpty
                                  ? () {
                                      onSuccess();
                                      Get.back();
                                      areYouSureToDelete.value = false;
                                    }
                                  : () {
                                      areYouSureToDelete.value = true;
                                    },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red.shade600,
                                ),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
