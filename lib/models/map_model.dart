import 'dart:convert';

import 'package:client_app/screen/widget/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

abstract class MapModel extends ChangeNotifier {
  Future<void> getOSMSuggestions(String query);
  Future<void> saveLocationToFirestore(BuildContext context);
  void selectLocation(dynamic item);
  void changeSelectedPoint(LatLng point);
  void clearSuggestions();
  void changeZoom(double zoom);
  void moveToCurrentLocation(BuildContext context, MapModelImpl mapModel);

  final MapController mapController = MapController();
  final TextEditingController searchController = TextEditingController();

  double currentZoom = 12.0;

  bool isLoading = false;

  List<dynamic> suggestions = [];

  LatLng selectedPoint = const LatLng(32.0259, 44.3615);
}

class MapModelImpl extends MapModel {
  MapModelImpl(BuildContext context) {}

  @override
  Future<void> getOSMSuggestions(String query) async {
    if (query.length < 2) {
      suggestions = [];
      notifyListeners();
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
        suggestions = json.decode(response.body);
        notifyListeners();
      }
    } catch (e) {
      print("❌ خطأ البحث المحلي: $e");
    }
  }

  @override
  void selectLocation(dynamic item) {
    final lat = double.tryParse(item['lat']?.toString() ?? '');
    final lon = double.tryParse(item['lon']?.toString() ?? '');

    if (lat != null && lon != null) {
      selectedPoint = LatLng(lat, lon);
      suggestions = [];
      searchController.text =
          item['display_name']?.toString() ?? 'Unknown Location';
      notifyListeners();

      mapController.move(selectedPoint, 15.0);
    } else {
      debugPrint("❌ تعذر اختيار الموقع: بيانات الإحداثيات غير صالحة: $item");
    }
  }

  @override
  Future<void> saveLocationToFirestore(BuildContext context) async {
    try {
      // 1. التحقق من صحة الموقع (لتجنب القيم الصفرية [0, 0])
      if (selectedPoint.latitude == 0.0 && selectedPoint.longitude == 0.0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⚠️ يرجى اختيار موقع صحيح على الخريطة أولاً'),
          ),
        );
        return;
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("يجب تسجيل الدخول أولاً");
      }

      String locationName = searchController.text.trim();
      if (locationName.isEmpty) {
        locationName = 'موقع غير مسمى';
      }

      final collection = FirebaseFirestore.instance.collection('orders');

      // 2. إرسال البيانات
      await collection.add({
        'user_id': user.uid,
        'name': locationName,
        'D': GeoPoint(selectedPoint.latitude, selectedPoint.longitude),
        'DP': GeoPoint(selectedPoint.latitude, selectedPoint.longitude),
        'created_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('✅ تم حفظ الموقع بنجاح')));
    } catch (e) {
      print("❌ خطأ أثناء حفظ الموقع: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ أثناء الحفظ: $e')));
    }
  }

  @override
  void changeSelectedPoint(LatLng point) {
    selectedPoint = point;
    notifyListeners();
  }

  @override
  void clearSuggestions() {
    searchController.clear();
    suggestions = [];
    notifyListeners();
  }

  @override
  void changeZoom(double zoom) {
    currentZoom = zoom;
    notifyListeners();
  }

  @override
  void moveToCurrentLocation(
    BuildContext context,
    MapModelImpl mapModel,
  ) async {
    mapModel.isLoading = true;
    notifyListeners();
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        customSnackbar('خطأ', 'يرجى تفعيل خدمة الموقع');
        mapModel.isLoading = false;
        notifyListeners();
        return;
      }

      // Check and request permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          customSnackbar('خطأ', 'تم رفض إذن الموقع');
          mapModel.isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        customSnackbar('خطأ', 'يرجى منح إذن الموقع من الإعدادات');
        mapModel.isLoading = false;
        notifyListeners();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Move map to current location
      mapModel.mapController.move(
        LatLng(position.latitude, position.longitude),
        mapModel.currentZoom, // Use the stored zoom from model
      );

      // Update selected point
      mapModel.changeSelectedPoint(
        LatLng(position.latitude, position.longitude),
      );

      customSnackbar('نجاح', 'تم الانتقال إلى موقعك الحالي');
    } catch (e) {
      customSnackbar('خطأ', 'حدث خطأ: ${e.toString()}');
      mapModel.isLoading = false;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }
}
