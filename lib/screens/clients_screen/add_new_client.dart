import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:html' as html;

class AddNewClient extends StatefulWidget {
  final Function() onClose;
  final Function() onRegisterClient;

  const AddNewClient(
      {super.key, required this.onClose, required this.onRegisterClient});

  @override
  State<AddNewClient> createState() => _AddNewClientState();
}

class _AddNewClientState extends State<AddNewClient> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? _imageUrl;
  Uint8List? _imageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height - 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black45, width: 1),
            ),
            padding: const EdgeInsets.all(30),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Add Client",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                          onTap: () => widget.onClose(),
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
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
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name is missing';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                cursorColor: Colors.black87,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is missing';
                                  }
                                  String emailPattern =
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                  RegExp regex = RegExp(emailPattern);
                                  if (!regex.hasMatch(value)) {
                                    return 'Please enter valid Email';
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
                                  labelText: 'Contact Number',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Contact is missing';
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
                                  labelText: 'Designation',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Designation is missing';
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
                                  labelText: 'Company',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Company is missing';
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
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is missing';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  _imageData != null
                                      ? Container(
                                          width: 350,
                                          height: 450,
                                          color: Colors.white,
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 40, 40, 100),
                                          child: Container(
                                            color: Colors.black,
                                            child: Image.memory(_imageData!),
                                          ),
                                        )
                                      : Container(
                                          width: 350,
                                          height: 450,
                                          color: Colors.white,
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 40, 40, 100),
                                          child: Container(
                                            color: Colors.black,
                                          ),
                                        ),
                                  Positioned(
                                    bottom: 35,
                                    child: InkWell(
                                      onTap: () async {
                                        await uploadImage();
                                      },
                                      overlayColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                      child: const Text(
                                        "Upload Picture",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                                if (_formKey.currentState!.validate()) {
                                  // setState(() {
                                  //   loading = true;
                                  //   Authentication().loginUser(
                                  //     email: _emailController.text,
                                  //     password: _passwordController.text,
                                  //     onSuccess: () {
                                  //       Authentication.userModel.isActive ==
                                  //               true
                                  //           ? setState(() {
                                  //               Navigator.pushNamed(
                                  //                   context, Routes.client);
                                  //               loading = false;
                                  //               _emailController.clear();
                                  //               _passwordController.clear();
                                  //             })
                                  //           : setState(() {
                                  //               inActiveDialog = true;
                                  //               loading = false;
                                  //               Authentication.userModel =
                                  //                   UserModel();
                                  //               Authentication().logOutUser();
                                  //             });
                                  //     },
                                  //     onError: () {
                                  //       setState(() {
                                  //         loading = false;
                                  //         showError();
                                  //       });
                                  //     },
                                  //   );
                                  // });
                                }
                              },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
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
                                  "Register Client",
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

  Future<void> uploadImage() async {
    final html.FileUploadInputElement uploadInput =
        html.FileUploadInputElement();
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
        });

        // Create a reference to the Firebase Storage location
        // final storageRef = _storage.ref().child('userProfiles/${file.name}');

        // Upload the image data
        // final uploadTask = storageRef.putData(data);

        // uploadTask.then((snapshot) async {
        //   final downloadURL = await snapshot.ref.getDownloadURL();
        //   setState(() {
        //     _imageUrl = downloadURL;
        //   });
        //   print('File uploaded at $downloadURL');
        // }).catchError((error) {
        //   print('Upload failed: $error');
        // });
      });
    });

    uploadInput.click(); // Trigger the file picker
  }
}
