import 'package:flutter/material.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'الرمز صالح لمدة 5 دقائق',
      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
      textAlign: TextAlign.center,
    );
  }
}
