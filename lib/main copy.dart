// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart'; // مكتبة الخرائط المفتوحة
// import 'package:latlong2/latlong.dart'; // للتعامل مع الإحداثيات
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: OSMMapScreen(),
//   ));
// }

// class OSMMapScreen extends StatefulWidget {
//   const OSMMapScreen({super.key});

//   @override
//   State<OSMMapScreen> createState() => _OSMMapScreenState();
// }

// class _OSMMapScreenState extends State<OSMMapScreen> {
//   final MapController _mapController = MapController();
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _suggestions = [];
//   LatLng _selectedPoint = const LatLng(32.0259, 44.3615); // مركز النجف

//   // 1. دالة البحث باستخدام Nominatim (مجانية بالكامل)
// // 1. دالة البحث باستخدام سيرفر النجف المحلي (Nominatim Local)
//   Future<void> _getOSMSuggestions(String query) async {
//     if (query.length < 2) { // تقليل عدد الأحرف للبحث المحلي السريع
//       setState(() => _suggestions = []);
//       return;
//     }

//     // ملاحظة هندسية: استخدم localhost إذا كنت تشغل الإيموليتر، 
//     // أو استخدم IP حاسوبك (مثل 192.168.1.5) إذا كنت تجرب من موبايل حقيقي.
//     final String url = "http://localhost:8080/search.php"
//         "?q=$query"
//         "&format=json"
//         "&addressdetails=1"
//         "&limit=10"
//         "&accept-language=ar";

//     try {
//       final response = await http.get(
//         Uri.parse(url),
//       );
      
//       if (response.statusCode == 200) {
//         setState(() {
//           _suggestions = json.decode(response.body);
//         });
//       }
//     } catch (e) {
//       print("❌ خطأ البحث المحلي: $e");
//       // نصيحة: إذا كنت تستخدم Android Emulator، جرب استبدال localhost بـ 10.0.2.2
//     }
//   }

//   // 2. دالة التعامل مع اختيار موقع من القائمة
//   void _selectLocation(dynamic item) {
//     final double lat = double.parse(item['lat']);
//     final double lon = double.parse(item['lon']);
    
//     setState(() {
//       _selectedPoint = LatLng(lat, lon);
//       _suggestions = [];
//       _searchController.text = item['display_name'];
//     });

//     _mapController.move(_selectedPoint, 15.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // 3. عرض الخريطة (بدون Token)
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               initialCenter: _selectedPoint,
//               initialZoom: 12.0,
//               onTap: (tapPosition, point) {
//                 setState(() => _selectedPoint = point);
//               },
//             ),
//             children: [
// TileLayer(
//   // هذا الرابط مخصص لإبراز الشوارع وخطوط النقل بشكل هندسي واضح
//   // urlTemplate: 'https://{s}.tile.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=YOUR_API_KEY',
//   // // ملاحظة: Thunderforest يتطلب API Key مجاني بسيط
//   // // إذا كنت تريد بديل مجاني تماماً وبدون حساب، استخدم الرابط أدناه:
//   // urlTemplate: 'https://api.thunderforest.com/transport-dark/{z}/{x}/{y}.png?apikey=aebbd3c90ecb423494467f5a30f64bb2',
//   urlTemplate: 'https://api.thunderforest.com/transport-dark/{z}/{x}/{y}.png?apikey=aebbd3c90ecb423494467f5a30f64bb2',
//   subdomains: const ['a', 'b', 'c', 'd'],
//   userAgentPackageName: 'com.pondo.ai',
// ),
//               MarkerLayer(
//                 markers: [
//                   Marker(
//                     point: _selectedPoint,
//                     width: 80,
//                     height: 80,
//                     child: const Icon(Icons.location_on, color: Colors.red, size: 45),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           // 4. واجهة البحث والاقتراحات
//           Positioned(
//             top: 50, left: 15, right: 15,
//             child: Column(
//               children: [
//                 Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: InputDecoration(
//                       hintText: "ابحث في النجف عبر OSM...",
//                       prefixIcon: const Icon(Icons.search, color: Colors.green),
//                       suffixIcon: IconButton(
//                         icon: const Icon(Icons.clear),
//                         onPressed: () {
//                           _searchController.clear();
//                           setState(() => _suggestions = []);
//                         },
//                       ),
//                       border: InputBorder.none,
//                       contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                     ),
//                     onChanged: _getOSMSuggestions,
//                   ),
//                 ),
//                 if (_suggestions.isNotEmpty)
//                   Container(
//                     margin: const EdgeInsets.only(top: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
//                     ),
//                     constraints: const BoxConstraints(maxHeight: 300),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: _suggestions.length,
//                       itemBuilder: (context, index) {
//                         final item = _suggestions[index];
//                         return ListTile(
//                           leading: const Icon(Icons.map_outlined, color: Colors.blueGrey),
//                           title: Text(item['display_name'], maxLines: 2, overflow: TextOverflow.ellipsis),
//                           onTap: () => _selectLocation(item),
//                         );
//                       },
//                     ),
//                   ),
//               ],
//             ),
//           ),
          
//           // زر تأكيد الموقع لـ PONDo AI
//           Positioned(
//             bottom: 30, left: 20, right: 20,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
//               ),
//               onPressed: () {
//                 print("✅ تم اختيار موقع لـ PONDo AI: ${_selectedPoint.latitude}, ${_selectedPoint.longitude}");
//               },
//               child: const Text("تأكيد العنوان", style: TextStyle(color: Colors.white, fontSize: 16)),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // مكتبة الخرائط المفتوحة
import 'package:latlong2/latlong.dart'; // للتعامل مع الإحداثيات
import 'dart:convert';
import 'package:http/http.dart' as http;


class OSMMapScreen extends StatefulWidget {
  const OSMMapScreen({super.key});

  @override
  State<OSMMapScreen> createState() => _OSMMapScreenState();
}

class _OSMMapScreenState extends State<OSMMapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _suggestions = [];
  LatLng _selectedPoint = const LatLng(32.0259, 44.3615); // مركز النجف
  
  // متغيرات الملاحة المضافة
  List<LatLng> _routePoints = [];
  String _distance = "";
  String _duration = "";

  // 1. دالة البحث باستخدام سيرفر النجف المحلي (Nominatim Local)
  Future<void> _getOSMSuggestions(String query) async {
    if (query.length < 2) {
      setState(() => _suggestions = []);
      return;
    }

    final String url = "http://localhost:8080/search.php"
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
    }
  }

  // دالة مضافة لحساب المسار والوقت عبر OSRM
  Future<void> _getRoute(LatLng destination) async {
    final start = const LatLng(32.0259, 44.3615); // نقطة الانطلاق (المركز)
    final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=polyline');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final route = data['routes'][0];
        setState(() {
          _routePoints = _decodePolyline(route['geometry']);
          _distance = "${(route['distance'] / 1000).toStringAsFixed(1)} كم";
          _duration = "${(route['duration'] / 60).toStringAsFixed(0)} دقيقة";
        });
      }
    } catch (e) {
      print("❌ خطأ في حساب الطريق: $e");
    }
  }

  // دالة فك تشفير الخطوط الجغرافية
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      shift = 0; result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  // 2. دالة التعامل مع اختيار موقع من القائمة
  void _selectLocation(dynamic item) {
    final double lat = double.parse(item['lat']);
    final double lon = double.parse(item['lon']);
    final destination = LatLng(lat, lon);

    setState(() {
      _selectedPoint = destination;
      _suggestions = [];
      _searchController.text = item['display_name'];
    });

    _mapController.move(_selectedPoint, 15.0);
    _getRoute(destination); // استدعاء حساب المسافة فور الاختيار
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 3. عرض الخريطة
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedPoint,
              initialZoom: 12.0,
              onTap: (tapPosition, point) {
                setState(() => _selectedPoint = point);
                _getRoute(point); // حساب المسافة عند الضغط اليدوي
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://api.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=aebbd3c90ecb423494467f5a30f64bb2',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.pondo.ai',
              ),
              // إضافة طبقة المسار (الخط الأزرق)
// داخل مصفوفة الـ children في FlutterMap
PolylineLayer(
  // تحديد النوع هنا <Polyline<Object>> يحل المشكلة
  polylines: _routePoints.isEmpty 
    ? <Polyline<Object>>[] 
    : <Polyline<Object>>[
        Polyline(
          points: _routePoints,
          strokeWidth: 5,
          color: Colors.blueAccent,
        ),
      ],
),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedPoint,
                    width: 80,
                    height: 80,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 15),
                  ),
                  // علامة مركز البداية (النجف)
                  const Marker(
                    point: LatLng(32.0259, 44.3615),
                    child: Icon(Icons.my_location, color: Colors.blue, size: 30),
                  ),
                ],
              ),
            ],
          ),

          // 4. واجهة البحث والاقتراحات
          Positioned(
            top: 50, left: 15, right: 15,
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _getOSMSuggestions,
                    decoration: InputDecoration(
                      hintText: "ابحث في النجف عبر OSM...",
                      prefixIcon: const Icon(Icons.search, color: Colors.green),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _suggestions = [];
                            _routePoints = [];
                            _distance = "";
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                  ),
                ),
                if (_suggestions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
                    ),
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        final item = _suggestions[index];
                        return ListTile(
                          leading: const Icon(Icons.map_outlined, color: Colors.blueGrey),
                          title: Text(item['display_name'], maxLines: 2, overflow: TextOverflow.ellipsis),
                          onTap: () => _selectLocation(item),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // لوحة معلومات المسافة والوقت المضافة
          if (_distance.isNotEmpty)
            Positioned(
              bottom: 110, left: 20, right: 20,
              child: Card(
                color: Colors.white.withValues(alpha: 0.9),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("🛣 المسافة: $_distance", style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text("🕒 الوقت: $_duration", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

          // زر تأكيد الموقع لـ PONDo AI
          Positioned(
            bottom: 30, left: 20, right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                print("✅ الموقع: ${_selectedPoint.latitude}, ${_selectedPoint.longitude} | المسافة: $_distance");
              },
              child: const Text("تأكيد العنوان", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }
}