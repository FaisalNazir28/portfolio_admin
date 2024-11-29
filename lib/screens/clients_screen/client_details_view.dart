import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:portfolio_admin/controllers/client_controller.dart';
import 'package:portfolio_admin/models/user_model.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class ClientDetailsView extends StatefulWidget {
  final Function() onClose;
  final UserModel clientDetails;

  const ClientDetailsView({
    super.key,
    required this.onClose,
    required this.clientDetails,
  });

  @override
  State<ClientDetailsView> createState() => _ClientDetailsViewState();
}

class _ClientDetailsViewState extends State<ClientDetailsView> {
  final clientController = Get.find<ClientController>();
  bool isHover = false;

  bool? hasImage;

  String? imageName;
  Uint8List? _imageData;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              clientController.isEditView.value = false;
                              widget.onClose();
                            },
                            overlayColor: WidgetStateProperty.all(Colors.transparent),
                            child: const Icon(
                              Ionicons.close_circle_outline,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Client Details",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Obx(() {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: clientController.isEditView.value ? () => selectImage() : null,
                                        onHover: (hover) {
                                          if (clientController.isEditView.value) {
                                            setState(() {
                                              isHover = hover;
                                            });
                                          }
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            _imageData != null
                                                ? Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                    child: Image.memory(_imageData!),
                                                  )
                                                : CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                      widget.clientDetails.profilePicture,
                                                    ),
                                                    radius: 50,
                                                  ),
                                            if (isHover)
                                              Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Colors.black54.withOpacity(0.20),
                                                ),
                                                child: const Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.camera,
                                                      size: 18,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "Change Picture",
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          clientController.isEditView.value
                                              ? TextField(
                                                  cursorColor: Colors.black87,
                                                  decoration: const InputDecoration(
                                                    isCollapsed: true,
                                                    constraints: BoxConstraints(maxWidth: 250),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.grey),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black54),
                                                    ),
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                  ),
                                                  controller: clientController.nameController,
                                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                                )
                                              : Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.clientDetails.name,
                                                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    if (widget.clientDetails.isAdmin)
                                                      const Icon(
                                                        CupertinoIcons.checkmark_shield_fill,
                                                        size: 30,
                                                        color: Colors.blueAccent,
                                                      )
                                                  ],
                                                ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            widget.clientDetails.email,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          clientController.isEditView.value
                                              ? Row(
                                                  children: [
                                                    const Text(
                                                      "Phone: ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    TextField(
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
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                      ),
                                                      controller: clientController.phoneController,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  "Phone: ${widget.clientDetails.phone}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Client UID: ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Client Designation: ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Client Company: ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Client Status: ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 30),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.clientDetails.uid,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  // color: Colors.black54,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              clientController.isEditView.value
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
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                      ),
                                                      controller: clientController.designationController,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    )
                                                  : Text(
                                                      widget.clientDetails.designation,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              clientController.isEditView.value
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
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                      ),
                                                      controller: clientController.companyController,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    )
                                                  : Text(
                                                      widget.clientDetails.company,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              clientController.isEditView.value
                                                  ? Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            clientController.statusController.value = true;
                                                            Get.forceAppUpdate();
                                                          },
                                                          child: Opacity(
                                                            opacity: clientController.statusController.value == true
                                                                ? 1
                                                                : 0.3,
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 10, vertical: 3),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(12),
                                                                color: Colors.green.shade100,
                                                              ),
                                                              child: const Text('Active'),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 15),
                                                        InkWell(
                                                          onTap: () {
                                                            clientController.statusController.value = false;
                                                            Get.forceAppUpdate();
                                                          },
                                                          child: Opacity(
                                                            opacity: clientController.statusController.value != true
                                                                ? 1
                                                                : 0.3,
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 10, vertical: 3),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(12),
                                                                color: Colors.red.shade100,
                                                              ),
                                                              child: const Text('Inactive'),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      widget.clientDetails.isActive ? "Active" : "Inactive",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            widget.clientDetails.isActive ? Colors.green : Colors.red,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: clientController.isEditView.value
                                  ? Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (_imageData != null) {
                                              clientController.updateClientData(
                                                  clientUid: widget.clientDetails.uid,
                                                  imageData: _imageData,
                                                  fileName: imageName);
                                            } else {
                                              clientController.updateClientData(clientUid: widget.clientDetails.uid);
                                            }
                                            clientController.isEditView.value = false;
                                            _imageData = null;
                                          },
                                          child: const Icon(
                                            CupertinoIcons.checkmark_alt,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            clientController.isEditView.value = false;
                                            _imageData = null;
                                          },
                                          child: const Icon(
                                            CupertinoIcons.clear,
                                            size: 20,
                                          ),
                                        )
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () {
                                        clientController.nameController.text = widget.clientDetails.name;
                                        clientController.phoneController.text = widget.clientDetails.phone;
                                        clientController.designationController.text = widget.clientDetails.designation;
                                        clientController.companyController.text = widget.clientDetails.company;
                                        clientController.statusController.value = widget.clientDetails.isActive;
                                        clientController.isEditView.value = true;
                                      },
                                      child: const Icon(
                                        CupertinoIcons.square_pencil,
                                        size: 20,
                                      ),
                                    ),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .15,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.82,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black45, width: 1),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Total balance",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "\$0",
                                style: TextStyle(fontSize: 19, color: Colors.green, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black45, width: 1),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total Projects",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    clientController.allClients.length.toString(),
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Active Projects",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    clientController.allClients.where((e) => e.isActive == true).length.toString(),
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Inactive Projects",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    clientController.allClients.where((e) => e.isActive == false).length.toString(),
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        addButton(icon: Ionicons.link_outline, title: "Bind Project", onTap: () {}),
                        addButton(icon: Ionicons.code_working_outline, title: "New Project", onTap: () {}),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Future<void> selectImage() async {
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
          _imageData = data;
          imageName = file.name;
          hasImage = true;
        });
      });
    });

    uploadInput.click(); // Trigger the file picker
  }

  Widget addButton({
    required IconData icon,
    required String title,
    required Function() onTap,
  }) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () {
        setState(() {
          onTap();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black45, width: 1),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
