import 'package:client_app/models/home/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedAddressesSection extends StatelessWidget {
  const SavedAddressesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersModel = context.read<OrdersModelImpl>();
    return Selector<OrdersModelImpl, String>(
      selector: (_, model) => ordersModel.selectedAddress ?? '',
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'اختيار تلقائي من العناوين المخزنة للبيج',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1E2C),
              ),
            ),
            const SizedBox(height: 12),
            
            if (ordersModel.savedAddresses.isEmpty)
              _buildEmptyState(context)
            else
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
                  children: [
                    ...ordersModel.savedAddresses.map((address) {
                      final isLast = address == ordersModel.savedAddresses.last;
                      return Column(
                        children: [
                          ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4F46E5).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.location_on_rounded,
                                color: Color(0xFF4F46E5),
                                size: 20,
                              ),
                            ),
                            title: Text(
                              address,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1A1E2C),
                              ),
                            ),
                            trailing: Radio<String>(
                              value: address,
                              groupValue: ordersModel.selectedAddress,
                              onChanged: (value) {
                                ordersModel.changeSelectedAddress(value);
                              },
                              activeColor: const Color(0xFF4F46E5),
                            ),
                            onTap: () {
                              ordersModel.changeSelectedAddress(address);
                            },
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
                    
                    // Add Address Button at bottom
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4F46E5).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Color(0xFF4F46E5),
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        'إضافة عنوان جديد',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFF4F46E5),
                        size: 16,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('سيتم إضافة عنوان جديد قريباً'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
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
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF4F46E5).withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_off_rounded,
              color: Color(0xFF4F46E5),
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'لا توجد عناوين محفوظة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1E2C),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'أضف عنوانك الأول الآن',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 160,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('سيتم إضافة عنوان جديد قريباً'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('إضافة عنوان'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}