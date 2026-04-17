import 'package:client_app/controller/auth/login_controller.dart';
import 'package:client_app/screen/widget/auth/Login/auth_phone_hint.dart';
import 'package:client_app/screen/widget/auth/Login/login_button.dart';
import 'package:client_app/screen/widget/auth/Login/phone_number_input.dart';
import 'package:client_app/screen/widget/auth/Login/term_and_privacy_text.dart';
import 'package:client_app/screen/widget/auth/Login/welcome_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LogincontrollerImp controller = Get.put(LogincontrollerImp());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7B2FF7), Color(0xFF9D4EDD), Color(0xFFE0AAFF)],
          ),
        ),
        child: Form(
          key: controller.formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo / Icon Section
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.lock_outline_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const WelcomeHeading(),
                        const SizedBox(height: 8),
                        const AuthPhoneHint(),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(28),
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
                    child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GetBuilder<LogincontrollerImp>(
                        builder: (controller) {
                          return PhoneNumberInput(
                            isoCode: 'IQ',
                            hintText: 'Enter your phone number',
                            controller: controller.phoneNumber,
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 28),

                      // Login Button
                      LoginButton(
                        onPressed: () {
                          controller.login();
                        },
                      ),
                    ],
                  ),

                  ),
                  const SizedBox(height: 40),

                  // Terms & Privacy
                  TermAndPrivacyText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
