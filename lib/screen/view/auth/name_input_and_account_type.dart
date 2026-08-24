import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/models/auth/login_model.dart';
import 'package:client_app/screen/widget/auth/NameInputAndAccountType/account_type_card.dart';
import 'package:client_app/screen/widget/auth/NameInputAndAccountType/name_field_card.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/auth/NameInputAndAccountType/name_field.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameInputAndAccountType extends StatelessWidget {
  const NameInputAndAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginModelImp(context),
      child: const NameInputView(),
    );
  }
}

class NameInputView extends StatefulWidget {
  const NameInputView({super.key});

  @override
  State<NameInputView> createState() => _NameInputViewState();
}

class _NameInputViewState extends State<NameInputView> {
  String? selectedAccountType; // 'business' or 'personal'

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
        padding: const EdgeInsets.all(20.0),
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

              // Name Fields in a Card
              NameFieldCard(),

              const SizedBox(height: 32),

              // Account Type Selection
              const Text(
                'نوع الحساب',
                style: TextStyle(
                  color: Color(0xFF1A1E2C),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              Consumer<LoginModelImp>(
                builder: (context, model, child) {
                  return AccountTypeCard(
                    title: 'حساب تجاري',
                    description:
                        'يفتح المحفظة، ورفع الطلبات بالجملة عبر متجر /بيج Excel، وتقارير المبيعات.',
                    icon: Icons.business_center,
                    isBusiness: true,
                    isSelected: model.selectedAccountType == 'business',
                    onTap: () {
                      model.setSelectedAccountType('business', context);
                    },
                  );
                },
              ),

              const SizedBox(height: 16),

              Consumer<LoginModelImp>(
                builder: (context, model, child) {
                  return AccountTypeCard(
                    title: 'حساب فردي',
                    description: 'لإرسال طرد شخصي بسيط من فرد لآخر بدون تعقيد.',
                    icon: Icons.person_outline,
                    isBusiness: false,
                    isSelected: model.selectedAccountType == 'personal',
                    onTap: () {
                      model.setSelectedAccountType('personal', context);
                    },
                  );
                },
              ),

              const SizedBox(height: 40),

              // Continue Button
              ContinueButton(
                onTap: () {
                  model.nameInputAndAccountType(context);
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
