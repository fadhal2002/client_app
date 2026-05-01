import 'package:client_app/screen/widget/home/HomePage/active_deliveries_section.dart';
import 'package:client_app/screen/widget/home/HomePage/custom_search_bar.dart';
import 'package:client_app/screen/widget/home/HomePage/home_page_app_bar.dart';
import 'package:client_app/screen/widget/home/HomePage/promo_bannar.dart';
import 'package:client_app/screen/widget/home/HomePage/QuickActions/quick_actions_section.dart';
import 'package:client_app/screen/widget/home/HomePage/recent_activity_section.dart';
import 'package:client_app/screen/widget/home/HomePage/welcome_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: HomePageAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeSection(),

            const SizedBox(height: 24),

            const CustomSearchBar(),

            const SizedBox(height: 24),

            const QuickActionsSection(),

            const SizedBox(height: 32),

            const ActiveDeliveriesSection(),

            const SizedBox(height: 32),

            const RecentActivitySection(),

            const SizedBox(height: 24),

            const PromoBannar(),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
