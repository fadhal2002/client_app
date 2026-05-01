import 'package:client_app/models/home/HomePage/AddDelivery/ride_confirmation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideOptionsCard extends StatelessWidget {
  final String distance;
  final String duration;

  const RideOptionsCard({
    super.key,
    required this.distance,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RideConfirmationModelImpl>(
      builder: (context, model, child) {
        model.calculatePrice(distance, duration, model.selectedVehicleType);
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
                    increasePercentage: 0, // No increase
                    color: const Color(0xFF4158D0),
                    isSelected: model.selectedVehicleType == 'economy',
                    onTap: () => model.selectVehicleType('economy'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRideOptionCard(
                    icon: Icons.electric_car,
                    title: 'سريع',
                    increasePercentage: 25, // 25% increase
                    color: const Color(0xFFFF9800),
                    isSelected: model.selectedVehicleType == 'fast',
                    onTap: () => model.selectVehicleType('fast'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRideOptionCard(
                    icon: Icons.airport_shuttle,
                    title: 'نقل ثقيل',
                    increasePercentage: 50, // 50% increase
                    color: const Color(0xFF4CAF50),
                    isSelected: model.selectedVehicleType == 'heavy',
                    onTap: () => model.selectVehicleType('heavy'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Show selected vehicle details
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'السعر النهائي:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Consumer<RideConfirmationModelImpl>(
                        builder: (context, model, child) {
                          return Text(
                            model.formatPrice(model.finalPrice2!),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4158D0),
                            ),
                          );
                        },
                      ),
                      if (model.selectedVehicleType != 'economy')
                        Text(
                          '+${_getIncreasePercentage(model.selectedVehicleType)}% زيادة',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildRideOptionCard({
  required IconData icon,
  required String title,
  required int increasePercentage,
  required Color color,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
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
          if (increasePercentage == 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'السعر الأساسي',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: Colors.green[700],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.trending_up, size: 10, color: color),
                  const SizedBox(width: 2),
                  Text(
                    '+$increasePercentage%',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

// Helper function to get increase percentage
int _getIncreasePercentage(String vehicleType) {
  switch (vehicleType) {
    case 'economy':
      return 0;
    case 'fast':
      return 25;
    case 'heavy':
      return 50;
    default:
      return 0;
  }
}
