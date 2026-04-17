import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/screen/widget/home/settings/profile_section.dart';
import 'package:client_app/screen/widget/home/settings/build_settings_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          'Settings',
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

          // Settings Sections
          BuildSettingsSection(
            title: 'Preferences',
            items: [
              SettingsItem(
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: 'English',
                onTap: () {
                  Get.toNamed('/LanguageScreen');
                },
              ),
              SettingsItem(
                icon: Icons.notifications_none_outlined,
                title: 'Notifications',
                subtitle: 'Daily reminders',
                onTap: () {
                  AppServices appServices = Get.find<AppServices>();
                  appServices.shared.clear();
                  Get.toNamed('/LoginScreen');
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          BuildSettingsSection(
            title: 'Support',
            items: [
              SettingsItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.feedback_outlined,
                title: 'Send Feedback',
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.star_outline,
                title: 'Rate the App',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Version Info
          Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
