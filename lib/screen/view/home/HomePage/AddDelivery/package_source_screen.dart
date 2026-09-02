import 'package:client_app/models/home/orders_model.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/custom_app_bar.dart';
import 'package:client_app/screen/widget/home/HomePage/QuickActions/AddDelivery/Orders/PackageSourceScreen/pickup_type_section.dart';
import 'package:client_app/screen/widget/home/HomePage/QuickActions/AddDelivery/Orders/PackageSourceScreen/saved_addresses_section.dart';
import 'package:client_app/screen/widget/home/HomePage/QuickActions/AddDelivery/Orders/PackageSourceScreen/vehicle_type_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageSourceScreen extends StatelessWidget {
  const PackageSourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrdersModelImpl>(
      create: (_) => OrdersModelImpl(context),
      child: const PackageSourceScreenView(),
    );
  }
}

class PackageSourceScreenView extends StatelessWidget {
  const PackageSourceScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersModel = context.read<OrdersModelImpl>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: CustomAppBar(title: 'إضافة طلب توصيل'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SavedAddressesSection(),

            const SizedBox(height: 24),

            PickupTypeSection(),

            const SizedBox(height: 24),

            VehicleTypeSection(),

            const SizedBox(height: 32),

            ContinueButton(
              onTap: () => ordersModel.performPackageSourceAction(context),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
