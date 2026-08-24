import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/models/auth/login_model.dart';
import 'package:client_app/screen/widget/auth/Login/phone_number_input.dart';
import 'package:client_app/screen/widget/auth/NameInputAndAccountType/account_type_card.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/auth/NameInputAndAccountType/name_field.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:flutter/material.dart';
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
    print(
      '============================================ EditProfileView build called',
    );
    final loginModel = context.read<LoginModelImp>();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
      body: Form(
        key: formKey,
        child: Padding(
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

                Selector<LoginModelImp, String?>(
                  selector: (context, model) => model.selectedAccountType,
                  builder: (context, selectedAccountType, child) {
                    return AccountTypeCard(
                      title: 'حساب تجاري',
                      description:
                          'يفتح المحفظة، ورفع الطلبات بالجملة عبر متجر /بيج Excel، وتقارير المبيعات.',
                      icon: Icons.business_center,
                      isBusiness: true,
                      isSelected: selectedAccountType == 'business',
                      onTap: () {
                        final model = context.read<LoginModelImp>();
                        model.setSelectedAccountType('business', context);
                      },
                    );
                  },
                ),

                const SizedBox(height: 16),

                Selector<LoginModelImp, String?>(
                  selector: (context, model) => model.selectedAccountType,
                  builder: (context, selectedAccountType, child) {
                    return AccountTypeCard(
                      title: 'حساب فردي',
                      description:
                          'لإرسال طرد شخصي بسيط من فرد لآخر بدون تعقيد.',
                      icon: Icons.person_outline,
                      isBusiness: false,
                      isSelected: selectedAccountType == 'personal',
                      onTap: () {
                        final model = context.read<LoginModelImp>();
                        model.setSelectedAccountType('personal', context);
                      },
                    );
                  },
                ),

                const SizedBox(height: 32),

                ContinueButton(
                  onTap: () {
                    loginModel.editProfile(context, formKey);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
