import 'package:flutter/material.dart';

class TermAndPrivacyText extends StatelessWidget {
  const TermAndPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'بالتسجيل، فإنك توافق على الشروط والأحكام وسياسة الخصوصية الخاصة بنا.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.7)),
    );
  }
}
