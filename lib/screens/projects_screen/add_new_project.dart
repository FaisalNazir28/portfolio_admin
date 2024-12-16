import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:html' as html;

class AddNewProject extends StatefulWidget {
  final Function() onClose;
  final Function() onRegisterProject;

  const AddNewProject({super.key, required this.onClose, required this.onRegisterProject});

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  bool? hasImage;

  String? imageName;

  List<Uint8List?> images = List.filled(22, null);

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
                          ))
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
                                      controller: _nameController,
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
                                      controller: _nameController,
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
                                      controller: _nameController,
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
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      cursorColor: Colors.black87,
                                      controller: _nameController,
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
                                    child: TextFormField(
                                      cursorColor: Colors.black87,
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Project Platform',
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
                                          return 'Project Platform is missing';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.black87,
                                      controller: _nameController,
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
                                      controller: _nameController,
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
                                    child: TextFormField(
                                      cursorColor: Colors.black87,
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Built for',
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
                                          return 'Built for is missing';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _emailController,
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
                                controller: _phoneController,
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
                                controller: _designationController,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Project Challenges Faced is missing';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _companyController,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Project Results & Impacts is missing';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _passwordController,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Client Review is missing';
                                  }
                                  return null;
                                },
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
                              child: Wrap(
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
                                            right: 10,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  images[index] = null;
                                                });
                                              },
                                              child: const Icon(
                                                Ionicons.close_outline,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        )
                        // Expanded(
                        //   child: Column(
                        //     children: [
                        //       Stack(
                        //         alignment: Alignment.bottomCenter,
                        //         children: [
                        //           Column(
                        //             children: [
                        //               Container(
                        //                 width: 350,
                        //                 height: 450,
                        //                 decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   border: hasImage != null && hasImage == false
                        //                       ? Border.all(
                        //                           color: Colors.red,
                        //                           width: 1,
                        //                         )
                        //                       : null,
                        //                 ),
                        //                 padding: const EdgeInsets.fromLTRB(40, 40, 40, 100),
                        //                 child: _imageData != null
                        //                     ? Column(
                        //                         mainAxisSize: MainAxisSize.min,
                        //                         children: [
                        //                           Image.memory(_imageData!),
                        //                           const SizedBox(
                        //                             height: 10,
                        //                           ),
                        //                           Text(
                        //                             imageName!,
                        //                             style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                        //                           ),
                        //                         ],
                        //                       )
                        //                     : Container(
                        //                         color: Colors.black,
                        //                       ),
                        //               ),
                        //             ],
                        //           ),
                        //           Positioned(
                        //             bottom: 35,
                        //             child: InkWell(
                        //               onTap: () async {
                        //                 await selectImage();
                        //               },
                        //               overlayColor: WidgetStateProperty.all(Colors.transparent),
                        //               child: const Text(
                        //                 "Upload Picture",
                        //                 style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // )
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
                                // UserModel userModel = UserModel(
                                //   email: _emailController.text,
                                //   name: _nameController.text,
                                //   phone: _phoneController.text,
                                //   designation: _designationController.text,
                                //   company: _companyController.text,
                                // );
                                // if (_formKey.currentState!.validate() && _imageData != null) {
                                //   setState(() {
                                //     loading = true;
                                //     ClientController().registerUser(
                                //       userModel: userModel,
                                //       password: _passwordController.text,
                                //       imageData: _imageData!,
                                //       fileName: imageName!,
                                //       onSuccess: () {
                                //         setState(() {
                                //           loading = false;
                                //           widget.onRegisterProject();
                                //           clearValues();
                                //         });
                                //       },
                                //       onError: () {
                                //         setState(() {
                                //           loading = false;
                                //         });
                                //       },
                                //     );
                                //   });
                                // } else if (_imageData == null) {
                                //   setState(() {
                                //     hasImage = false;
                                //   });
                                // }
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
          // imageName = file.name;
          // hasImage = true;
        });
      });
    });

    uploadInput.click(); // Trigger the file picker
  }

  void clearValues() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _designationController.clear();
    _companyController.clear();
  }
}
