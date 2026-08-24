import 'package:flutter/material.dart';

class KeyFeaturesCard extends StatelessWidget {
  const KeyFeaturesCard({super.key});

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
              Icon(Icons.star_outline, size: 20, color: Color(0xFF4158D0)),
              SizedBox(width: 8),
              Text(
                'لماذا تختار نقلة؟',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1E2C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            icon: Icons.speed,
            title: 'توصيل سريع',
            description: 'توصيل سريع وكفء إلى باب منزلك',
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            icon: Icons.location_on,
            title: 'تتبع الوقت الفعلي',
            description: 'تتبع حزمة الخاصة بك في كل خطوة',
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            icon: Icons.security,
            title: 'آمن وموثوق',
            description: 'تتم معالجة حزمك بعناية قصوى',
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            icon: Icons.support_agent,
            title: 'دعماء 24/7',
            description: 'فريقنا مستعد دائماً لمساعدتك',
          ),
        ],
      ),
    );
  }
}

Widget _buildFeatureItem({
  required IconData icon,
  required String title,
  required String description,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFF4158D0).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF4158D0)),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1E2C),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    ],
  );
}
