import 'package:client_app/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationButton extends StatefulWidget {
  const LocationButton({super.key});

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  @override
  Widget build(BuildContext context) {
    final mapModel = context.read<MapModelImpl>();

    return Positioned(
      bottom: 100, // Position at bottom-right, above continue button
      right: 20,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: mapModel.isLoading
            ? const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Color(0xFF1A1E2C),
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(
                  Icons.my_location,
                  color: Color(0xFF1A1E2C),
                  size: 33,
                ),
                onPressed: () {
                  mapModel.moveToCurrentLocation(context, mapModel);
                },
                splashRadius: 26,
              ),
      ),
    );
  }
}
