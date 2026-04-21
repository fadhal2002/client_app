import 'package:client_app/screen/view/home/HomePage/AddDelivery/route_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // مكتبة الخرائط المفتوحة
import 'package:get/route_manager.dart';
import 'package:latlong2/latlong.dart'; // للتعامل مع الإحداثيات
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _suggestions = [];
  LatLng _selectedPoint = const LatLng(32.0259, 44.3615); // مركز النجف

  // 1. دالة البحث باستخدام Nominatim (مجانية بالكامل)
  // 1. دالة البحث باستخدام سيرفر النجف المحلي (Nominatim Local)
  Future<void> _getOSMSuggestions(String query) async {
    if (query.length < 2) {
      // تقليل عدد الأحرف للبحث المحلي السريع
      setState(() => _suggestions = []);
      return;
    }

    // ملاحظة هندسية: استخدم localhost إذا كنت تشغل الإيموليتر،
    // أو استخدم IP حاسوبك (مثل 192.168.1.5) إذا كنت تجرب من موبايل حقيقي.
    final String url =
        "http://localhost:8080/search.php"
        "?q=$query"
        "&format=json"
        "&addressdetails=1"
        "&limit=10"
        "&accept-language=ar";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _suggestions = json.decode(response.body);
        });
      }
    } catch (e) {
      print("❌ خطأ البحث المحلي: $e");
      // نصيحة: إذا كنت تستخدم Android Emulator، جرب استبدال localhost بـ 10.0.2.2
    }
  }

  // 2. دالة التعامل مع اختيار موقع من القائمة
  void _selectLocation(dynamic item) {
    final double lat = double.parse(item['lat']);
    final double lon = double.parse(item['lon']);

    setState(() {
      _selectedPoint = LatLng(lat, lon);
      _suggestions = [];
      _searchController.text = item['display_name'];
    });

    _mapController.move(_selectedPoint, 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 3. عرض الخريطة (بدون Token)
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedPoint,
              initialZoom: 12.0,
              onTap: (tapPosition, point) {
                setState(() => _selectedPoint = point);
              },
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
                    point: _selectedPoint,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 45,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 4. واجهة البحث والاقتراحات
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "ابحث في النجف عبر OSM...",
                      prefixIcon: const Icon(Icons.search, color: Colors.green),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _suggestions = []);
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                    ),
                    onChanged: _getOSMSuggestions,
                  ),
                ),
                if (_suggestions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 5),
                      ],
                    ),
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        final item = _suggestions[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.map_outlined,
                            color: Colors.blueGrey,
                          ),
                          title: Text(
                            item['display_name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () => _selectLocation(item),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // زر تأكيد الموقع لـ PONDo AI
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                print(
                  "✅ تم اختيار موقع لـ PONDo AI: ${_selectedPoint.latitude}, ${_selectedPoint.longitude}",
                );

                Get.to(() => RouteMapScreen(selectedPoint: _selectedPoint,));
              },
              child: const Text(
                "تأكيد العنوان",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
