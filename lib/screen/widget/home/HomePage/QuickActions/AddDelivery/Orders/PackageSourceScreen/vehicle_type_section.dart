import 'package:client_app/models/home/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleTypeSection extends StatelessWidget {
  const VehicleTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersModel = context.read<OrdersModelImpl>();
    return Selector<OrdersModelImpl, String?>(
      selector: (_, model) => ordersModel.selectedVehicleType ?? '',
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'نوع المركبة',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1E2C),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: ordersModel.vehicleTypes.map((vehicle) {
                  final isLast = vehicle == ordersModel.vehicleTypes.last;
                  final isSelected = ordersModel.selectedVehicleType == vehicle;

                  return Column(
                    children: [
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4F46E5).withOpacity(0.1)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.directions_car_rounded,
                            color: isSelected
                                ? const Color(0xFF4F46E5)
                                : Colors.grey.shade600,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          vehicle,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF4F46E5)
                                : const Color(0xFF1A1E2C),
                          ),
                        ),
                        trailing: isSelected
                            ? Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4F46E5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              )
                            : null,
                        onTap: () {
                          ordersModel.changeSelectedVehicleType(vehicle);
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                      ),
                      if (!isLast)
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.shade100,
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
