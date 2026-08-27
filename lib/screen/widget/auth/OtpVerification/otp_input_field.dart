import 'package:client_app/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpInputField extends StatelessWidget {
  const OtpInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            6,
            (index) => _buildOtpDigitField(context, index),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpDigitField(BuildContext context, int index) {
    final model = context.read<LoginModelImp>();
    return SizedBox(
      width: 41,
      child: TextFormField(
        textDirection: TextDirection.ltr,
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
            model.UserEnteredCode += value;
          } else if (value.isEmpty && index > 0) {
            model.UserEnteredCode = model.UserEnteredCode.substring(
              0,
              model.UserEnteredCode.length - 1,
            );
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
