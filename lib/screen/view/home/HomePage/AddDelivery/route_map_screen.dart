import 'package:client_app/screen/view/home/HomePage/AddDelivery/ride_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

class RouteMapScreen extends StatefulWidget {
  final LatLng? selectedPoint;

  const RouteMapScreen({super.key, this.selectedPoint});

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _suggestions = [];

  // نقطة الانطلاق: تأخذ الموقع المحدد مسبقاً أو الموقع الافتراضي
  LatLng get pickUpPoint =>
      widget.selectedPoint ?? const LatLng(32.0259, 44.3615);

  LatLng? _dropOffPoint;

  // نقطة الوصول: تأخذ موقع الوصول المختار
  LatLng get dropOffPoint => _dropOffPointNotNull(_dropOffPoint);

  LatLng _dropOffPointNotNull(LatLng? point) {
    return point ?? const LatLng(32.0259, 44.3615);
  }

  List<LatLng> _routePoints = [];
  String _distance = "";
  String _duration = "";

  // 📌 دالة حفظ الطلب والموقع في الفايربيز (Firestore)
  // Future<void> _saveLocationToFirestore() async {
  //   try {
  //     // 1. التحقق من صحة نقطة الانطلاق لتجنب القيم الصفرية [0, 0]
  //     if (pickUpPoint.latitude == 0.0 && pickUpPoint.longitude == 0.0) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('⚠️ يرجى اختيار موقع صحيح على الخريطة أولاً'),
  //         ),
  //       );
  //       return;
  //     }

  //     String locationName = _searchController.text.trim();
  //     if (locationName.isEmpty) {
  //       locationName = ' HaPPY DELIVERY       ';
  //     }

  //     final collection = FirebaseFirestore.instance.collection('orders');

  //     // 3. إرسال البيانات إلى مجموعة Orders
  //     await collection.add({
  //       'name': locationName,
  //       'D': GeoPoint(pickUpPoint.latitude, pickUpPoint.longitude), // نقطة الانطلاق
  //       'DP': GeoPoint(dropOffPoint.latitude, dropOffPoint.longitude), // نقطة الوصول
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('✅ تم حفظ الطلب بنجاح في قاعدة البيانات')),
  //     );
  //   } catch (e) {
  //     print("❌ خطأ أثناء حفظ الطلب: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('حدث خطأ أثناء الحفظ: $e')),
  //     );
  //   }
  // }

  // 📌 جلب العنوان النصي بناءً على الإحداثيات
  Future<String> _getAddressFromLatLng(LatLng point) async {
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

  // 📌 جلب الاقتراحات للبحث
  Future<void> _getOSMSuggestions(String query) async {
    if (query.length < 2) {
      setState(() => _suggestions = []);
      return;
    }

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
    }
  }

  // 📌 رسم المسار وتحديث المسافة والوقت
  Future<void> _getRoute(LatLng destination) async {
    final start = widget.selectedPoint ?? const LatLng(32.0259, 44.3615);

    setState(() {
      _dropOffPoint = destination;
    });

    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${start.longitude},${start.latitude};'
      '${destination.longitude},${destination.latitude}'
      '?overview=full&geometries=polyline',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final route = data['routes'][0];

          // فك تشفير المسار
          final decodedPoints = decodePolyline(route['geometry']);

          setState(() {
            _routePoints = decodedPoints
                .map(
                  (point) => LatLng(point[0].toDouble(), point[1].toDouble()),
                )
                .toList();

            _distance = "${(route['distance'] / 1000).toStringAsFixed(1)} كم";
            _duration = "${(route['duration'] / 60).toStringAsFixed(0)} دقيقة";
          });
        }
      }
    } catch (e) {
      print("❌ خطأ في حساب الطريق: $e");
    }
  }

  // 📌 تحديد الموقع من القائمة المنسدلة
  void _selectLocation(dynamic item) {
    final double lat = double.parse(item['lat'].toString());
    final double lon = double.parse(item['lon'].toString());
    final destination = LatLng(lat, lon);

    setState(() {
      _dropOffPoint = destination;
      _suggestions = [];
      _searchController.text = item['display_name'].toString();
    });

    _mapController.move(destination, 15.0);
    _getRoute(destination);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: pickUpPoint,
              initialZoom: 12.0,
              onTap: (tapPosition, point) {
                print("نقطة الوصول مختارة: ${point.latitude}, ${point.longitude}");
                _getRoute(point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=aebbd3c90ecb423494467f5a30f64bb2',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.pondo.ai',
              ),
              PolylineLayer(
                polylines: _routePoints.isEmpty
                    ? <Polyline>[]
                    : <Polyline>[
                        Polyline(
                          points: _routePoints,
                          strokeWidth: 5,
                          color: Colors.blueAccent,
                        ),
                      ],
              ),
              MarkerLayer(
                markers: [
                  // نقطة الانطلاق
                  Marker(
                    point: pickUpPoint,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.green,
                      size: 45,
                    ),
                  ),
                  // نقطة الوصول
                  if (_dropOffPoint != null)
                    Marker(
                      point: dropOffPoint,
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
                    onChanged: _getOSMSuggestions,
                    decoration: InputDecoration(
                      hintText: "ابحث عن موقع...",
                      prefixIcon: const Icon(Icons.search, color: Colors.green),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _suggestions = [];
                            _routePoints = [];
                            _dropOffPoint = null;
                            _distance = "";
                            _duration = "";
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                    ),
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
          if (_distance.isNotEmpty)
            Positioned(
              bottom: 110,
              left: 20,
              right: 20,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("المسافة: $_distance"),
                      Text("الوقت: $_duration"),
                    ],
                  ),
                ),
              ),
            ),
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
              onPressed: () async {
                if (_dropOffPoint == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '⚠️ يرجى تحديد نقطة الوصول على الخريطة أو البحث عنها أولاً',
                      ),
                    ),
                  );
                  return;
                }

                // 📌 حفظ الموقع والطلب في فايربيز أولاً
                // await _saveLocationToFirestore();

                final address = await _getAddressFromLatLng(pickUpPoint);
                final dropOffAddress = await _getAddressFromLatLng(
                  dropOffPoint,
                );

                print("نقطة الانطلاق (D): $address");
                print("نقطة الوصول (DP): $dropOffAddress");

                // 📌 الانتقال للشاشة التالية بعد الحفظ بنجاح
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RideConfirmationScreen(
                      pickupLocation: pickUpPoint,
                      dropoffLocation: dropOffPoint,
                      pickupAddress: address,
                      dropoffAddress: dropOffAddress,
                      distance: _distance,
                      duration: _duration,
                    ),
                  ),
                  (route) => false,
                );
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