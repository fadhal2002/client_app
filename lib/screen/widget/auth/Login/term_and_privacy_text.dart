import 'package:flutter/material.dart';

class TermAndPrivacyText extends StatelessWidget {
  const TermAndPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'By continuing, you agree to our Terms of Service\nand Privacy Policy',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.7)),
    );
  }
}
