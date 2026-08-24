import 'package:flutter/material.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'النشاط الأخير',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1E2C),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF4158D0),
                ),
                child: const Text('عرض الكل'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Recent Activity List
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildActivityItem(
                icon: Icons.check_circle,
                title: 'تم تسليم الطلب',
                subtitle: 'تم تسليم الحزمة بنجاح',
                time: 'منذ ساعتين',
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(height: 12),
              _buildActivityItem(
                icon: Icons.pending,
                title: 'تم تأكيد الطلب',
                subtitle: 'تم تأكيد الطلب من قبل السائق',
                time: 'منذ 3 ساعات',
                color: const Color(0xFFFF9800),
              ),
              const SizedBox(height: 12),
              _buildActivityItem(
                icon: Icons.attach_money,
                title: 'تم استلام الدفع',
                subtitle: 'تم استلام الدفع بنجاح',
                time: 'منذ 5 ساعات',
                color: const Color(0xFF4158D0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildActivityItem({
  required IconData icon,
  required String title,
  required String subtitle,
  required String time,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.05),
          spreadRadius: 1,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: color),
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
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Text(time, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
      ],
    ),
  );
}
