import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

abstract class CustomMapController extends GetxController {
  selectLocation(dynamic item);
  getOSMSuggestions(String query);
  onMapTap(bool selectMode);
  clearSearch();
  getRoute(LatLng destination);

  final MapController mapController = MapController();

  final TextEditingController searchController = TextEditingController();

  List<dynamic> suggestions = [];
  List<LatLng> routePoints = [];

  LatLng selectedPoint = const LatLng(32.0259, 44.3615); // مركز النجف

  String distance = "";
  String duration = "";

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
      shift = 0;
      result = 0;
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

  // 1. دالة البحث باستخدام Nominatim (مجانية بالكامل)
  // 1. دالة البحث باستخدام سيرفر النجف المحلي (Nominatim Local)
}

class CustomMapControllerImp extends CustomMapController {
  

  @override
  void selectLocation(dynamic item) {
    final double lat = double.parse(item['lat']);
    final double lon = double.parse(item['lon']);

    selectedPoint = LatLng(lat, lon);
    suggestions = [];
    searchController.text = item['display_name'];

    mapController.move(selectedPoint, 15.0);
    update();
  }

  @override
  Future<void> getOSMSuggestions(String query) async {
    if (query.length < 2) {
      // تقليل عدد الأحرف للبحث المحلي السريع
      suggestions = [];
      update();
      return;
    }
    // ملاحظة هندسية: استخدم localhost إذا كنت تشغل الإيموليتر，
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
        suggestions = json.decode(response.body);
        update();
      }
    } catch (e) {
      print("❌ خطأ البحث المحلي: $e");
      // نصيحة: إذا كنت تستخدم Android Emulator، جرب استبدال localhost بـ 10.0.2.2
    }
  }

  @override
  void Function(TapPosition, LatLng)? onMapTap(bool getRouteMode) {
    return (tapPosition, point) {
      selectedPoint = point;
      if (getRouteMode) {
        getRoute(point);
      }
      update();
    };
  }

  @override
  void Function()? clearSearch() {
    searchController.clear();
    suggestions = [];
    routePoints = [];
    distance = "";
    update();
    return null;
  }

  Future<void> getRoute(LatLng destination) async {
    final start = selectedPoint; // نقطة الانطلاق (المركز)
    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=polyline',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final route = data['routes'][0];
        routePoints = _decodePolyline(route['geometry']);
        distance = "${(route['distance'] / 1000).toStringAsFixed(1)} كم";
        duration = "${(route['duration'] / 60).toStringAsFixed(0)} دقيقة";
        update();
      }
    } catch (e) {
      print("❌ خطأ في حساب الطريق: $e");
    }
  }
}
