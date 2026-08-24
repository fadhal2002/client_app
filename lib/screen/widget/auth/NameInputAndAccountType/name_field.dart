import 'package:client_app/models/auth/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameField extends StatelessWidget {
  IconData icon;
  String name = '';
  NameField({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return NameFieldView(name: name, icon: icon);
  }
}

class NameFieldView extends StatelessWidget {
  IconData icon;
  String name = '';
  NameFieldView({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    final model = context.read<LoginModelImp>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF4158D0).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: Color(0xFF4158D0)),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1E2C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
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
          child: TextField(
            controller: name == 'الاسم الأول'
                ? model.firstName
                : model.lastName,
            decoration: InputDecoration(
              hintText: 'ادخل ${name.toLowerCase()}',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF4158D0),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
