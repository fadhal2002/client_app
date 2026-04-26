import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:client_app/screen/widget/home/settings/HelpCenter/build_contact_section.dart';
import 'package:client_app/screen/widget/home/settings/HelpCenter/contact_card.dart';
import 'package:client_app/screen/widget/home/settings/HelpCenter/response_time_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

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
            // Get.back();
          },
        ),
        title: const Text(
          'مركز المساعدة',
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
            HeaderIlustration(
              title: 'كيف يمكننا مساعدتك؟',
              subtitle: 'احصل على الدعم أو تواصل معنا',
              icon: Icons.help_center_outlined,
            ),

            const SizedBox(height: 24),

            // Contact Options Section
            BuildContactSection(
              children: [
                ContactCard(
                  icon: Icons.email_outlined,
                  title: 'الدعم عبر البريد',
                  subtitle: 'أرسل لنا رسالة',
                  detail: 'basfadl404@gmail.com',
                  color: const Color(0xFF4158D0),
                  type: 'email',
                ),
                const SizedBox(height: 12),
                ContactCard(
                  icon: Icons.phone_outlined,
                  title: 'اتصل بنا',
                  subtitle: 'تواصل معنا عبر واتساب',
                  detail: '+964 783 782 255 7',
                  color: const Color(0xFF4CAF50),
                  type: 'whatsapp',
                ),
              ],
            ),

            const SizedBox(height: 24),

            ResponseTimeInfo(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}