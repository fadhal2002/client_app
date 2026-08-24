import 'package:client_app/screen/widget/auth/NameInputAndAccountType/name_field.dart';
import 'package:flutter/material.dart';

class NameFieldCard extends StatelessWidget {
  const NameFieldCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    NameField(
                      name: 'الاسم الأول',
                      icon: Icons.account_circle_outlined,
                    ),
                    const SizedBox(height: 16),
                    NameField(name: 'الاسم الأخير', icon: Icons.badge),
                  ],
                ),
              );
  }
}