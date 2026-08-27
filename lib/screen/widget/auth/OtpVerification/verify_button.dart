import 'package:client_app/screen/widget/custom_snackbar.dart';
import 'package:client_app/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyButton extends StatelessWidget {
  const VerifyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<LoginModelImp>();
    return ElevatedButton(
      onPressed: () {
        if (model.UserEnteredCode == model.VerificationCode) {
          model
              .getAppServices(context)
              .shared
              .setString('phoneNumber', model.phoneNumber.text.trim());
          customSnackbar('نجاح', 'تم التحقق بنجاح!');
          Navigator.pushNamed(context, '/NameInputAndAccountType');
        } else {
          customSnackbar('خطأ', 'رمز OTP غير صحيح. يرجى المحاولة مرة أخرى.');
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
