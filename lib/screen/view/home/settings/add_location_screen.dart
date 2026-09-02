import 'package:client_app/screen/widget/home/settings/LocationSetup/location_card.dart';
import 'package:client_app/screen/widget/home/settings/LocationSetup/selected_location_preview.dart';
import 'package:flutter/material.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';

class LocationSetupScreen extends StatelessWidget {
  const LocationSetupScreen({super.key});

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
          'تحديد الموقع',
          style: TextStyle(
            color: Color(0xFF1A1E2C),
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderIlustration(
                title: 'أين تتواجد؟',
                subtitle: 'حدد موقعك لتقديم خدمة أفضل',
                icon: Icons.location_on,
              ),

              const SizedBox(height: 32),

              LocationCard(
                title: 'الموقع الحالي',
                subtitle: 'استخدم GPS لتحديد موقعك',
                icon: Icons.gps_fixed,
                isCurrentLocation: true,
                onTap: () {
                  // Non-functional - just UI
                  print('Get current location');
                },
              ),

              const SizedBox(height: 16),

              LocationCard(
                title: 'إدخال يدوي',
                subtitle: 'أدخل عنوانك يدوياً',
                icon: Icons.edit_location,
                isCurrentLocation: false,
                onTap: () {
                  // Non-functional - just UI
                  print('Manual location entry');
                },
              ),

              const SizedBox(height: 24),

              SelectedLocationPreview(),

              const SizedBox(height: 32),

              // Continue Button
              ContinueButton(
                onTap: () {
                  // Non-functional - just UI
                  print('Location saved, navigating to home');
                  // Navigation would go here
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
