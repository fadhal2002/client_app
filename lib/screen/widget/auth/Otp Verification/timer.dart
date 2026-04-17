import 'package:flutter/material.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Code expires in 05:00',
      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
      textAlign: TextAlign.center,
    );
  }
}
