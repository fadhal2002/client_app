import 'package:client_app/controller/auth/login_controller.dart';
import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/auth/UserName/name_field.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    AppServices appServices = Get.find<AppServices>();
    LogincontrollerImp controller = Get.find<LogincontrollerImp>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1E2C)),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Personal Info',
          style: TextStyle(
            color: Color(0xFF1A1E2C),
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderIlustration(
                title: 'Personal Info',
                subtitle: 'Please provide your personal information',
                icon: Icons.person,
              ),

              const SizedBox(height: 32),

              NameField(
                name: 'First Name',
                icon: Icons.account_circle_outlined,
              ),

              const SizedBox(height: 20),

              NameField(name: 'Last Name', icon: Icons.badge),

              const SizedBox(height: 32),

              ContinueButton(
                onTap: () {
                  if (controller.firstName.text.isEmpty ||
                      controller.lastName.text.isEmpty) {
                    customSnackbar(
                      context,
                      'Error',
                      'Please enter both first and last names.',
                    );
                  } else {
                    customSnackbar(
                      context,
                      'Success',
                      'Names saved successfully!',
                    );
                    appServices.shared.setString(
                      'firstName',
                      controller.firstName.text.trim(),
                    );
                    appServices.shared.setString(
                      'lastName',
                      controller.lastName.text.trim(),
                    );
                    appServices.shared.setString(
                      'phoneNumber',
                      controller.phoneNumber.text.trim(),
                    );
                    appServices.shared.setString('screen', 'homePage');
                    Get.toNamed('/HomePageState');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
