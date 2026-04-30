import 'package:flutter/material.dart';

class PromoCode extends StatelessWidget {
  const PromoCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'أدخل رمز الخصم',
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          prefixIcon: const Icon(
            Icons.local_offer,
            color: Color(0xFF4158D0),
            size: 20,
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(4),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4158D0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text('تطبيق', style: TextStyle(fontSize: 12)),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
