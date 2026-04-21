import 'package:client_app/controller/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OtpInputField extends StatelessWidget {
  const OtpInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          6,
          (index) => _buildOtpDigitField(context, index),
        ),
      ),
    );
  }

  Widget _buildOtpDigitField(BuildContext context, int index) {
    Logincontroller controller = Get.find<LogincontrollerImp>();
    return SizedBox(
      width: 41,
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF7B2FF7),
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF7B2FF7), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 6) {
            FocusScope.of(context).nextFocus();
            controller.UserEnteredCode += value;
          } else if (value.isEmpty && index > 0) {
            controller.UserEnteredCode = controller.UserEnteredCode.substring(
              0,
              controller.UserEnteredCode.length - 1,
            );
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
