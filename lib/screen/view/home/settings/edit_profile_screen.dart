import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/models/auth/login_model.dart';
import 'package:client_app/screen/widget/auth/Login/phone_number_input.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/auth/UserName/name_field.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginModelImp(context),
      child: const EditProfileView(),
    );
  }
}

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    AppServices appServices = Provider.of<AppServices>(context, listen: false);
    final loginModel = context.watch<LoginModelImp>();

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
          'المعلومات الشخصية',
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
                title: 'تعديل الملف الشخصي',
                subtitle: 'قم بتحديث معلوماتك الشخصية لإبقاء ملفك محدثاً',
                icon: Icons.person,
              ),

              const SizedBox(height: 32),

              NameField(
                name: 'الاسم الأول',
                icon: Icons.account_circle_outlined,
              ),

              const SizedBox(height: 20),

              NameField(name: 'اسم العائلة', icon: Icons.badge),

              const SizedBox(height: 32),

              PhoneNumberInput(
                onInputChanged: (value) {},
                isoCode: 'IQ',
                controller: loginModel.phoneNumber,
              ),

              const SizedBox(height: 32),

              ContinueButton(
                onTap: () {
                  if (loginModel.firstName.text.isEmpty ||
                      loginModel.lastName.text.isEmpty) {
                    customSnackbar(
                      'خطأ',
                      'يرجى إدخال الاسم الأول واسم العائلة.',
                    );
                  } else {
                    customSnackbar('نجاح', 'تم حفظ البيانات بنجاح!');

                    appServices.shared.setString(
                      'firstName',
                      loginModel.firstName.text.trim(),
                    );

                    appServices.shared.setString(
                      'lastName',
                      loginModel.lastName.text.trim(),
                    );

                    appServices.shared.setString(
                      'phoneNumber',
                      loginModel.phoneNumber.text.trim(),
                    );

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/HomePageState',
                      (route) => false,
                    );
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
