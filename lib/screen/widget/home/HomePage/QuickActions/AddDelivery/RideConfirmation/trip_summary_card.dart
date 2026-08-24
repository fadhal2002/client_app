import 'package:client_app/models/home/HomePage/AddDelivery/ride_confirmation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripSummaryCard extends StatelessWidget {
  final String pickupAddress;
  final String dropoffAddress;
  final String distance;
  final String duration;

  const TripSummaryCard({
    super.key,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.distance,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<RideConfirmationModelImpl>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF4158D0).withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4158D0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.receipt_long,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'تفاصيل الرحلة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1E2C),
                  ),
                ),
              ],
            ),
          ),

          // Locations
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildLocationItem(
                  icon: Icons.circle,
                  iconColor: const Color(0xFF4CAF50),
                  title: 'نقطة الانطلاق',
                  address: pickupAddress,
                ),
                const SizedBox(height: 16),
                _buildLocationItem(
                  icon: Icons.location_on,
                  iconColor: const Color(0xFFFF9800),
                  title: 'نقطة الوصول',
                  address: dropoffAddress,
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Trip Stats
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.straighten,
                  label: 'المسافة',
                  value: distance,
                ),
                Container(width: 1, height: 30, color: Colors.grey[200]),
                _buildStatItem(
                  icon: Icons.access_time,
                  label: 'الوقت المتوقع',
                  value: duration,
                ),
                Container(width: 1, height: 30, color: Colors.grey[200]),
                _buildStatItem(
                  icon: Icons.attach_money,
                  label: 'السعر',
                  value:
                      model.formatPrice(model.calculatePrice(distance, duration, 'economy')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildLocationItem({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String address,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              address,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1E2C),
              ),
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildStatItem({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Column(
    children: [
      Icon(icon, color: const Color(0xFF4158D0), size: 20),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1E2C),
        ),
      ),
    ],
  );
}
