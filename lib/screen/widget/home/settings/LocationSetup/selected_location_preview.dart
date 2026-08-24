import 'package:flutter/material.dart';

class SelectedLocationPreview extends StatelessWidget {
  const SelectedLocationPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_pin, color: Color(0xFF1A1E2C), size: 20),
              SizedBox(width: 8),
              Text(
                'الموقع المحدد',
                style: TextStyle(
                  color: Color(0xFF1A1E2C),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, color: Color(0xFFBDBDBD), size: 48),
                  SizedBox(height: 8),
                  Text(
                    'سيظهر الموقع هنا',
                    style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1E2C).withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.home, color: Color(0xFF1A1E2C), size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'لم يتم تحديد موقع بعد',
                    style: TextStyle(color: Color(0xFF616161), fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
