import 'package:flutter/material.dart';

class RideOptionsCard extends StatelessWidget {
  final double estimatedPrice;
  const RideOptionsCard({super.key, required this.estimatedPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'اختر نوع الرحلة',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1E2C),
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildRideOptionCard(
                icon: Icons.directions_car,
                title: 'اقتصادي',
                price: '\$${(estimatedPrice * 0.8).toStringAsFixed(2)}',
                color: const Color(0xFF4158D0),
                isSelected: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildRideOptionCard(
                icon: Icons.electric_car,
                title: 'VIP',
                price: '\$${(estimatedPrice * 1.5).toStringAsFixed(2)}',
                color: const Color(0xFFFF9800),
                isSelected: false,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildRideOptionCard(
                icon: Icons.local_shipping,
                title: 'شاحنة',
                price: '\$${(estimatedPrice * 2).toStringAsFixed(2)}',
                color: const Color(0xFF4CAF50),
                isSelected: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildRideOptionCard({
  required IconData icon,
  required String title,
  required String price,
  required Color color,
  required bool isSelected,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isSelected ? color.withOpacity(0.1) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isSelected ? color : Colors.grey[200]!,
        width: isSelected ? 2 : 1,
      ),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? color : const Color(0xFF1A1E2C),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}
