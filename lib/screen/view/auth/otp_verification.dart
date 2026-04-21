import 'package:client_app/controller/auth/login_controller.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/screen/widget/auth/OtpVerification/otp_input_field.dart';
import 'package:client_app/screen/widget/auth/OtpVerification/resend_code_section.dart';
import 'package:client_app/screen/widget/auth/OtpVerification/verification_prompt.dart';
import 'package:client_app/screen/widget/auth/OtpVerification/verify_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerification extends StatelessWidget {
  final String? phoneNumber;

  const OtpVerification({super.key, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    AppServices appServices = Get.find<AppServices>();
    return Scaffold(
      backgroundColor: Color(0xFFE0AAFF),
      body: Container(
        // margin: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7B2FF7), Color(0xFF9D4EDD), Color(0xFFE0AAFF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    iconSize: 24,
                  ),
                ),

                const SizedBox(height: 20),

                // Logo / Icon Section
                VerificationPrompt(
                  phoneNumber: appServices.shared.getString("phoneNumber"),
                ),

                // OTP Input Container
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 32,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // OTP Input Fields
                      const Text(
                        'Enter Verification Code',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7B2FF7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      OtpInputField(),

                      const SizedBox(height: 32),

                      VerifyButton(),

                      const SizedBox(height: 24),

                      // Resend Code Section
                      ResendCodeSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
