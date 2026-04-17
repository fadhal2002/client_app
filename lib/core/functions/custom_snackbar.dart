import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    backgroundColor: const Color(0xFF7B2FF7),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 4),
  );
}
