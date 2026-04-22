import 'package:client_app/controller/home/custom_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class LocationPicker extends GetView<CustomMapControllerImp> {
  const LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    print("Building LocationPicker");
    return FlutterMap(
      mapController: controller.mapController,
      options: MapOptions(
        initialCenter: controller.selectedPoint,
        initialZoom: 12.0,
        onTap: controller.onMapTap(false),
      ),
      children: [
        TileLayer(
          // هذا الرابط مخصص لإبراز الشوارع وخطوط النقل بشكل هندسي واضح
          // urlTemplate: 'https://{s}.tile.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=YOUR_API_KEY',
          // // ملاحظة: Thunderforest يتطلب API Key مجاني بسيط
          // // إذا كنت تريد بديل مجاني تماماً وبدون حساب، استخدم الرابط أدناه:
          // urlTemplate: 'https://api.thunderforest.com/transport-dark/{z}/{x}/{y}.png?apikey=aebbd3c90ecb423494467f5a30f64bb2',
          urlTemplate:
              'https://api.thunderforest.com/transport-dark/{z}/{x}/{y}.png?apikey=aebbd3c90ecb423494467f5a30f64bb2',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.pondo.ai',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: controller.selectedPoint,
              width: 80,
              height: 80,
              child: const Icon(Icons.location_on, color: Colors.red, size: 45),
            ),
          ],
        ),
      ],
    );
  }
}
