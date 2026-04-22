import 'package:client_app/controller/home/custom_map_controller.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // مكتبة الخرائط المفتوحة
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RouteMapScreen extends StatelessWidget {



  /*                                       بس اوصل لذه الصفحة، التطبيق يجمد                           */



  const RouteMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Building RouteMapScreen");
    CustomMapController controller = Get.find<CustomMapControllerImp>();
    return Scaffold(
      body: Stack(
        children: [
          // 3. عرض الخريطة
          FlutterMap(
            mapController: controller.mapController, /* اذا تشيل السطر، الصفحة تشتغل بس خصائص الخريطة والتتبع يتعطلن اكيد */
            options: MapOptions(
              initialCenter: const LatLng(32.0259, 44.3615),
              initialZoom: 12.0,
              onTap: controller.onMapTap(false),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=aebbd3c90ecb423494467f5a30f64bb2',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.pondo.ai',
              ),
              // إضافة طبقة المسار (الخط الأزرق)
              // داخل مصفوفة الـ children في FlutterMap
              PolylineLayer(
                // تحديد النوع هنا <Polyline<Object>> يحل المشكلة
                polylines: controller.routePoints.isEmpty
                    ? <Polyline<Object>>[]
                    : <Polyline<Object>>[
                        Polyline(
                          points: controller.routePoints,
                          strokeWidth: 5,
                          color: Colors.blueAccent,
                        ),
                      ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: controller.selectedPoint,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 15,
                    ),
                  ),
                  // علامة مركز البداية (النجف)
                  Marker(
                    point: controller.selectedPoint,
                    child: Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 30,
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
                    controller: controller.searchController,
                    onChanged: controller.getOSMSuggestions,
                    decoration: InputDecoration(
                      hintText: "ابحث في النجف عبر OSM...",
                      prefixIcon: const Icon(Icons.search, color: Colors.green),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => controller.clearSearch(),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
                if (controller.suggestions.isNotEmpty)
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
                      itemCount: controller.suggestions.length,
                      itemBuilder: (context, index) {
                        final item = controller.suggestions[index];
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
                          onTap: () => controller.selectLocation(item),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // لوحة معلومات المسافة والوقت المضافة
          if (controller.distance.isNotEmpty)
            Positioned(
              bottom: 110,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "🛣 المسافة: ${controller.distance}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "🕒 الوقت: ${controller.duration}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ContinueButton(
              onTap: () {
                if (controller.selectedPoint.latitude != 0 &&
                    controller.selectedPoint.longitude != 0) {
                  Get.back();
                } else {
                  Get.snackbar(
                    "خطأ",
                    "يرجى اختيار موقع صالح على الخريطة.",
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
