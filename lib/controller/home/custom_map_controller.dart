// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class CustomMapController extends GetxController {
//   // Controllers
//   final MapController mapController = MapController();
//   final TextEditingController searchController = TextEditingController();
  
//   // Reactive variables
//   var suggestions = <dynamic>[].obs;
//   var selectedPoint = const LatLng(32.0259, 44.3615).obs;
//   var routePoints = <LatLng>[].obs;
//   var distance = "".obs;
//   var duration = "".obs;
//   var isLoading = false.obs;

//   MapControllerX({required LatLng initialPoint}) : selectedPoint = initialPoint.obs;
  
//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }
  
//   // Search function using Nominatim
//   Future<void> getOSMSuggestions(String query) async {
//     if (query.length < 2) {
//       suggestions.clear();
//       return;
//     }
    
//     isLoading.value = true;
    
//     final String url = "http://localhost:8080/search.php"
//         "?q=$query"
//         "&format=json"
//         "&addressdetails=1"
//         "&limit=10"
//         "&accept-language=ar";
    
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         suggestions.value = json.decode(response.body);
//       }
//     } catch (e) {
//       print("❌ خطأ البحث المحلي: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
  
//   // Select location from suggestions
//   void selectLocation(dynamic item) {
//     final double lat = double.parse(item['lat']);
//     final double lon = double.parse(item['lon']);
    
//     selectedPoint.value = LatLng(lat, lon);
//     suggestions.clear();
//     searchController.text = item['display_name'];
    
//     mapController.move(selectedPoint.value, 15.0);
//   }
  
//   // Update selected point on map tap
//   void updateSelectedPoint(LatLng point) {
//     selectedPoint.value = point;
//   }
  
//   // Get route between two points using OSRM
//   Future<void> getRoute(LatLng destination) async {
//     isLoading.value = true;
    
//     final start = selectedPoint.value;
//     final url = Uri.parse(
//       'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=polyline',
//     );
    
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final route = data['routes'][0];
        
//         routePoints.value = _decodePolyline(route['geometry']);
//         distance.value = "${(route['distance'] / 1000).toStringAsFixed(1)} كم";
//         duration.value = "${(route['duration'] / 60).toStringAsFixed(0)} دقيقة";
//       }
//     } catch (e) {
//       print("❌ خطأ في حساب الطريق: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
  
//   // Decode polyline geometry
//   List<LatLng> _decodePolyline(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;
    
//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
      
//       lat += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       shift = 0;
//       result = 0;
      
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
      
//       lng += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       points.add(LatLng(lat / 1E5, lng / 1E5));
//     }
//     return points;
//   }
  
//   // Clear search
//   void clearSearch() {
//     searchController.clear();
//     suggestions.clear();
//   }
  
//   // Clear route
//   void clearRoute() {
//     routePoints.clear();
//     distance.value = "";
//     duration.value = "";
//   }
// }