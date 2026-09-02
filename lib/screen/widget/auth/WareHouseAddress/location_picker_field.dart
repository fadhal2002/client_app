import 'dart:convert';

import 'package:client_app/screen/widget/auth/WareHouseAddress/mini_map_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationPickerField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final VoidCallback onTap;
  final LatLng? selectedLocation;
  final Function(LatLng, String) onLocationSelected;

  const LocationPickerField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.onTap,
    this.selectedLocation,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF1A1E2C)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1A1E2C),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    hint,
                    style: TextStyle(
                      color: selectedLocation != null
                          ? Colors.black
                          : Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1E2C).withOpacity(0.06),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xFF1A1E2C),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Mini map showing selected location
        SizedBox(
          height: 200,
          width: double.infinity,
          child: MiniMapView(
            initialLocation: selectedLocation ?? const LatLng(32.0259, 44.3615),
            onLocationChanged: (point) async {
              // Get address from coordinates
              final address = await _getAddressFromLatLng(point);
              onLocationSelected(point, address);
            },
            isInteractive: false, // Make it read-only
          ),
        ),
      ],
    );
  }

  Future<String> _getAddressFromLatLng(LatLng point) async {
    // You can implement this using your existing method
    final url =
        "https://nominatim.openstreetmap.org/reverse"
        "?lat=${point.latitude}"
        "&lon=${point.longitude}"
        "&format=json"
        "&accept-language=ar";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"User-Agent": "FlutterApp"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name'] ?? "عنوان غير معروف";
      }
    } catch (e) {
      print("❌ خطأ في جلب العنوان: $e");
    }

    return "عنوان غير معروف";
  }
}
