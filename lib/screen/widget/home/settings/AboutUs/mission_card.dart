import 'package:flutter/material.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.rocket_launch_outlined,
                size: 20,
                color: Color(0xFF4158D0),
              ),
              SizedBox(width: 8),
              Text(
                'مهمتنا',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1E2C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'لتحقيق ثورة في تجربة التوصيل من خلال تقديم خدمات سريعة وموثوقة واقتصادية تجعل الحياة أسهل للجميع.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
