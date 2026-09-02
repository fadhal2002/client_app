import 'package:client_app/models/home/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickupTypeSection extends StatelessWidget {
  const PickupTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersModel = context.read<OrdersModelImpl>();
    return Selector<OrdersModelImpl, String?>(
      selector: (_, model) => ordersModel.selectedPickupType ?? '',
      builder: (context, value, child) {
    print('Selected Pickup Type: ${ordersModel.selectedPickupType}');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'نوع الاستلام',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1E2C),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: ordersModel.pickupTypes.map((type) {
                final isSelected =
                    ordersModel.selectedPickupType == type['title'];
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ordersModel.changeSelectedPickupType(type['title']);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: type == ordersModel.pickupTypes.first ? 0 : 8,
                        left: type == ordersModel.pickupTypes.last ? 0 : 8,
                      ),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4F46E5).withOpacity(0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4F46E5)
                              : Colors.grey.shade200,
                          width: isSelected ? 2 : 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFF4F46E5,
                                  ).withOpacity(0.15),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF4F46E5)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              type['icon'],
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            type['title'],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF4F46E5)
                                  : const Color(0xFF1A1E2C),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            type['subtitle'],
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
