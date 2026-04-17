import 'package:client_app/controller/auth/login_controller.dart';
import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/screen/widget/auth/Login/phone_number_input.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/auth/User%20Name/name_field.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppServices appServices = Get.find<AppServices>();
    LogincontrollerImp controller = Get.put(LogincontrollerImp());

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
                title: 'Edit Your Profile',
                subtitle:
                    'Update your personal information to keep your profile up to date',
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

              PhoneNumberInput(
                onInputChanged: (value) {},
                isoCode: 'IQ',
                controller: appServices.shared.getString('phoneNumber') != null
                    ? TextEditingController(
                        text: appServices.shared.getString('phoneNumber'),
                      )
                    : controller.phoneNumber,
              ),
              const SizedBox(height: 32),

              ContinueButton(
                onTap: () {
                  print('First Name: ${controller.firstName.text}');
                  print('Last Name: ${controller.lastName.text}');
                  print(
                    'first name from shared: ${appServices.shared.getString('firstName')}',
                  );
                  print(
                    'last name from shared: ${appServices.shared.getString('lastName')}',
                  );
                  if (controller.firstName.text.isEmpty ||
                      controller.lastName.text.isEmpty) {
                    customSnackbar(
                      'Error',
                      'Please enter both first and last names.',
                    );
                  } else {
                    customSnackbar('Success', 'Names saved successfully!');
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
                    // Get.toNamed('/HomePageState');
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
