import 'package:flutter/material.dart';

class AuthPhoneHint extends StatelessWidget {
  const AuthPhoneHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'يرجى إدخال رقم هاتفك لتلقي رمز التحقق',
      style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.85)),
      textAlign: TextAlign.center,
    );
  }
}
