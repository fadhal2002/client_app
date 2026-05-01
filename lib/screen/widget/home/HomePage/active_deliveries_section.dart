import 'package:flutter/material.dart';

class ActiveDeliveriesSection extends StatelessWidget {
  const ActiveDeliveriesSection({super.key});

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
                'الطلبات النشطة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1E2C),
                ),
              ),
              Text(
                '2 نشطة',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildDeliveryCard(
                orderId: '#NK-2847',
                pickup: 'الموقع الأول',
                dropoff: 'الموقع الثاني',
                status: 'استلام',
                time: 'منذ 10 دقائق',
                color: const Color(0xFF4158D0),
                onTap: () {},
              ),
              const SizedBox(width: 16),
              _buildDeliveryCard(
                orderId: '#NK-2848',
                pickup: 'الموقع الأول',
                dropoff: 'الموقع الثاني',
                status: 'في الطريق',
                time: 'منذ 25 دقيقة',
                color: const Color(0xFFFF9800),
                onTap: () {},
              ),
              const SizedBox(width: 16),
              _buildDeliveryCard(
                orderId: '#NK-2849',
                pickup: 'الموقع الأول',
                dropoff: 'الموقع الثاني',
                status: 'تم التسليم',
                time: 'منذ ساعة',
                color: const Color(0xFF4CAF50),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildDeliveryCard({
  required String orderId,
  required String pickup,
  required String dropoff,
  required String status,
  required String time,
  required Color color,
  required VoidCallback onTap,
}) {
  return Container(
    width: 280,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              orderId,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.location_on, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                pickup,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on, size: 14, color: Color(0xFF4158D0)),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                dropoff,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1E2C),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.access_time, size: 12, color: Colors.grey[400]),
            const SizedBox(width: 4),
            Text(time, style: TextStyle(fontSize: 10, color: Colors.grey[400])),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: Text(
              status == 'استلام' ? 'ملاحة' : 'تتبع',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}
