import 'package:flutter/material.dart';

class AuthPhoneHint extends StatelessWidget {
  const AuthPhoneHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'please Enter your phone number to continue',
      style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.85)),
      textAlign: TextAlign.center,
    );
  }
}
