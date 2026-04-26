import 'package:flutter/material.dart';

class ConnectWithUsCard extends StatelessWidget {
  const ConnectWithUsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
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
                Icons.link_outlined,
                size: 20,
                color: Color(0xFF4158D0),
              ),
              SizedBox(width: 8),
              Text(
                'تواصل معنا',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1E2C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSocialLink(
            icon: Icons.web,
            title: 'الموقع الإلكتروني',
            detail: 'www.nakla.com',
            color: const Color(0xFF4158D0),
            onTap: () {},
          ),
          _buildSocialLink(
            icon: Icons.email_outlined,
            title: 'البريد الإلكتروني',
            detail: 'hello@nakla.com',
            color: const Color(0xFF00B4DB),
            onTap: () {},
          ),
          _buildSocialLink(
            icon: Icons.phone_outlined,
            title: 'الخط الساخن',
            detail: '+1 (800) 123-4567',
            color: const Color(0xFF4CAF50),
            onTap: () {},
          ),
          _buildSocialLink(
            icon: Icons.camera_alt_outlined,
            title: 'إنستغرام',
            detail: '@nakla',
            color: const Color(0xFFE4405F),
            onTap: () {},
          ),
          _buildSocialLink(
            icon: Icons.facebook,
            title: 'فيسبوك',
            detail: 'NaklaDelivery',
            color: const Color(0xFF1877F2),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

Widget _buildSocialLink({
  required IconData icon,
  required String title,
  required String detail,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: color),
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
                  detail,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 18,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}