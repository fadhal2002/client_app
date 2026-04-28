import 'package:client_app/screen/view/home/settings/connect_with_us_card.dart';
import 'package:client_app/screen/widget/home/settings/AboutUs/description_card.dart';
import 'package:client_app/screen/widget/home/settings/AboutUs/key_features_card.dart';
import 'package:client_app/screen/widget/home/settings/AboutUs/logo_and_name.dart';
import 'package:client_app/screen/widget/home/settings/AboutUs/mission_card.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1E2C)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'من نحن',
          style: TextStyle(
            color: Color(0xFF1A1E2C),
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LogoAndName(),

            const SizedBox(height: 24),

            DescriptionCard(),

            const SizedBox(height: 16),

            MissionCard(),

            const SizedBox(height: 16),

            KeyFeaturesCard(),

            const SizedBox(height: 16),

            ConnectWithUsCard(),

            const SizedBox(height: 24),

            Center(
              child: Text(
                '© 2024 Nakla. جميع الحقوق محفوظة',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}