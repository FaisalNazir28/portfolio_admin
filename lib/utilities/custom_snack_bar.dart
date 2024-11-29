import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void showSnackBar({required String message, Color? color}) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        maxWidth: Get.width * .2,
        backgroundColor: color ?? Colors.black87,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.only(bottom: 20),
        borderRadius: 20,
      ),
    );
  }
}
