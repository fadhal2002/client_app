import 'package:client_app/screen/widget/home/settings/profile_section.dart';
import 'package:client_app/screen/widget/home/settings/settings_section.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'الإعدادات',
          style: TextStyle(
            color: Color(0xFF1A1E2C),
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile Section
          ProfileSection(),

          const SizedBox(height: 24),

          const SizedBox(height: 16),

          SettingsSection(
            title: 'الدعم',
            items: [
              SettingsItem(
                icon: Icons.help_outline,
                title: 'مركز المساعدة',
                onTap: () {
                  Navigator.pushNamed(context, '/HelpCenterScreen');
                },
              ),
              SettingsItem(
                icon: Icons.info_outline,
                title: "من نحن",
                onTap: () {
                  Navigator.pushNamed(context, '/AboutUsScreen');
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Version Info
          Center(
            child: Text(
              'الإصدار 1.0.0',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}