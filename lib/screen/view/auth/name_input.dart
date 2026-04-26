import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/models/auth/login_model.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/auth/UserName/name_field.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginModelImp(context),
      child: const NameInputView(),
    );
  }
}

class NameInputView extends StatelessWidget {
  const NameInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<LoginModelImp>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1E2C)),
          onPressed: () {
            Navigator.pop(context);
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
                title: 'المعلومات الشخصية',
                subtitle: 'يرجى إدخال معلوماتك الشخصية',
                icon: Icons.person,
              ),

              const SizedBox(height: 32),

              NameField(
                name: 'الاسم الأول',
                icon: Icons.account_circle_outlined,
              ),

              const SizedBox(height: 20),

              NameField(name: 'الاسم الأخير', icon: Icons.badge),

              const SizedBox(height: 32),

              ContinueButton(
                onTap: () {
                  print('First Name: ${model.firstName.text}');
                  print('Last Name: ${model.lastName.text}');

                  if (model.firstName.text.isEmpty ||
                      model.lastName.text.isEmpty) {
                    customSnackbar(
                      'خطأ',
                      'يرجى إدخال الاسم الأول واسم العائلة',
                    );
                  } else {
                    customSnackbar('نجاح', 'تم حفظ الأسماء بنجاح');

                    model
                        .getAppServices(context)
                        .shared
                        .setString('firstName', model.firstName.text.trim());

                    model
                        .getAppServices(context)
                        .shared
                        .setString('lastName', model.lastName.text.trim());

                    model
                        .getAppServices(context)
                        .shared
                        .setString('screen', 'homePage');

                    model.getAppServices(context).login();

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
