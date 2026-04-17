import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:client_app/screen/widget/home/settings/language/language_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'English'; // Default selected language

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
            Get.back();
          },
        ),
        title: const Text(
          'Language',
          style: TextStyle(
            color: Color(0xFF1A1E2C),
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderIlustration(
              title: 'Choose your preferred language',
              subtitle: 'Select the language you want to use the app in',
              icon: Icons.language,
            ),

            const SizedBox(height: 32),

            // Language Options
            const Text(
              'Select Language',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1E2C),
              ),
            ),
            const SizedBox(height: 16),

            // English Option
            LanguageCard(
              languageName: 'English',
              nativeName: 'English',
              flag: '🇺🇸',
              icon: Icons.language,
              isSelected: _selectedLanguage == 'English',
              onTap: () {
                setState(() {
                  _selectedLanguage = 'English';
                });
              },
            ),

            const SizedBox(height: 12),

            // Arabic Option
            LanguageCard(
              languageName: 'Arabic',
              nativeName: 'العربية',
              flag: '🇸🇦',
              icon: Icons.language,
              isSelected: _selectedLanguage == 'Arabic',
              onTap: () {
                setState(() {
                  _selectedLanguage = 'Arabic';
                });
              },
            ),

            const SizedBox(height: 32),

            ContinueButton(
              onTap: () {
                Get.back();
              },
            ),

            const SizedBox(height: 16),

            // Info text
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline, size: 14, color: Colors.grey[400]),
                  const SizedBox(width: 4),
                  Text(
                    'You can change this later in settings',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
