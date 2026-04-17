import 'package:client_app/controller/auth/login_controller.dart';
import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyButton extends StatelessWidget {
  const VerifyButton({super.key});

  @override
  Widget build(BuildContext context) {
    LogincontrollerImp controller = Get.find<LogincontrollerImp>();
    return ElevatedButton(
      onPressed: () {
        if (controller.UserEnteredCode == controller.VerificationCode) {
          customSnackbar('Success', 'OTP Verified Successfully');
          Get.toNamed('/NameInput');
        } else {
          customSnackbar('Error', 'Invalid OTP. Please try again.');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF7B2FF7),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      child: const Text(
        'Verify & Continue',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
