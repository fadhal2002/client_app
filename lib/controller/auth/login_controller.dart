import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/screen/view/auth/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Logincontroller extends GetxController {
  void startCountdown();
  void startInitialTimer();
  void resendCode();

  var countdown = 0.obs;
  var isResendEnabled = true.obs;

  String VerificationCode = '123456';
  String UserEnteredCode = '';

  late TextEditingController phoneNumber;
  late TextEditingController firstName;
  late TextEditingController lastName;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AppServices appServices = Get.find<AppServices>();
}

class LogincontrollerImp extends Logincontroller {
  @override
  void onInit() {
    phoneNumber = TextEditingController(
      text: appServices.shared.getString('phoneNumber') ?? '',
    );
    firstName = TextEditingController(
      text: appServices.shared.getString('firstName') ?? '',
    );
    lastName = TextEditingController(
      text: appServices.shared.getString('lastName') ?? '',
    );
    super.onInit();
  }

  void login() {
    if (formKey.currentState!.validate()) {
      appServices.shared.setString("phoneNumber", phoneNumber.text.trim());
      Get.toNamed('/OtpVerification');
    } else {
      // customSnackbar(

      //   'Invalid Phone Number',
      //   'Please enter a valid phone number',
      // );
    }
    update();
  }

  @override
  void startInitialTimer() {
    isResendEnabled.value = true;
    countdown.value = 0;
  }

  @override
  void startCountdown() {
    if (countdown.value > 0) return;

    isResendEnabled.value = false;
    countdown.value = 5;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (countdown.value > 0) {
        countdown.value--;
        return true;
      } else {
        isResendEnabled.value = true;
        return false;
      }
    });
  }

  @override
  void resendCode() {
    if (isResendEnabled.value) {
      startCountdown();
      // customSnackbar(
      //   'Code Resent',
      //   'A new verification code has been sent to your WhatsApp',
      // );
    }
  }
}
