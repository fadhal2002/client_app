import 'package:client_app/models/map_model.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/mini_map_view.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class LocationPickerField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final VoidCallback onTap;

  const LocationPickerField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mapModel = context.read<MapModelImpl>();
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
                    style: TextStyle(color: Colors.black, fontSize: 14),
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

        Selector<MapModelImpl, LatLng?>(
          selector: (context, model) => model.selectedPoint,
          builder: (context, selectedPoint, child) {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: MiniMapView(
                initialLocation: selectedPoint ?? const LatLng(0, 0),
                isInteractive: false,
              ),
            );
          },
        ),
      ],
    );
  }
}
