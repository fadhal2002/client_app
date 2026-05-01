import 'package:client_app/screen/view/home/HomePage/AddDelivery/Location_Picker_screen.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

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
                'إجراءات سريعة',
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

        // Quick Action Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildQuickAction(
                icon: Icons.add_location_alt_outlined,
                title: 'طلب توصيل جديد',
                color: const Color(0xFF4158D0),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationPickerScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(width: 12),
              _buildQuickAction(
                icon: Icons.history,
                title: 'السجل',
                color: const Color(0xFFFF9800),
                onTap: () {},
              ),
              const SizedBox(width: 12),
              _buildQuickAction(
                icon: Icons.support_agent,
                title: 'الدعم',
                color: const Color(0xFF4CAF50),
                onTap: () {
                  Navigator.pushNamed(context, '/HelpCenterScreen');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildQuickAction({
  required IconData icon,
  required String title,
  required Color color,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1E2C),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
