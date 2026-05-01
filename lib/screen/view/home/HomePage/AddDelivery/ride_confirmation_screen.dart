import 'package:client_app/models/home/HomePage/AddDelivery/ride_confirmation_model.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/custom_app_bar.dart';
import 'package:client_app/screen/widget/home/HomePage/QuickActions/AddDelivery/RideConfirmation/payment_method.dart';
import 'package:client_app/screen/widget/home/HomePage/QuickActions/AddDelivery/RideConfirmation/promo_code.dart';
import 'package:client_app/screen/widget/home/HomePage/QuickActions/AddDelivery/RideConfirmation/ride_options_card.dart';
import 'package:client_app/screen/widget/home/HomePage/QuickActions/AddDelivery/RideConfirmation/trip_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class RideConfirmationScreen extends StatelessWidget {
  final LatLng pickupLocation;
  final LatLng dropoffLocation;
  final String pickupAddress;
  final String dropoffAddress;
  final String distance;
  final String duration;

  const RideConfirmationScreen({
    super.key,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.distance,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RideConfirmationModelImpl(),
      child: RideConfirmationView(
        pickupLocation: pickupLocation,
        dropoffLocation: dropoffLocation,
        pickupAddress: pickupAddress,
        dropoffAddress: dropoffAddress,
        distance: distance,
        duration: duration,
      ),
    );
  }
}

class RideConfirmationView extends StatelessWidget {
  final LatLng pickupLocation;
  final LatLng dropoffLocation;
  final String pickupAddress;
  final String dropoffAddress;
  final String distance;
  final String duration;
  const RideConfirmationView({
    super.key,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.distance,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: CustomAppBar(
        title: 'تأكيد الرحلة',
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/HomeScreenState',
          (route) => false,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TripSummaryCard(
                    pickupAddress: pickupAddress,
                    dropoffAddress: dropoffAddress,
                    distance: distance,
                    duration: duration,
                  ),

                  const SizedBox(height: 20),

                  RideOptionsCard(distance: distance, duration: duration),

                  const SizedBox(height: 20),

                  // Payment Method
                  PaymentMethod(),

                  const SizedBox(height: 20),

                  // Promo Code
                  PromoCode(),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ContinueButton(
              text: 'تأكيد الرحلة',
              onTap: () {
                // Handle continue action
              },
            ),
          ),
        ],
      ),
    );
  }
}
