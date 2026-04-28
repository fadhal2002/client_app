// lib/models/map_model.dart
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapModel extends ChangeNotifier {
  // ---------- State ----------
  LatLng _startPoint = const LatLng(32.0259, 44.3615); // default (Najaf)
  LatLng? _destinationPoint;
  List<dynamic> _suggestions = [];
  List<LatLng> _routePoints = [];
  String _distance = "";
  String _duration = "";

  // ---------- Getters ----------
  LatLng get startPoint => _startPoint;
  LatLng? get destinationPoint => _destinationPoint;
  List<dynamic> get suggestions => _suggestions;
  List<LatLng> get routePoints => _routePoints;
  String get distance => _distance;
  String get duration => _duration;
  bool get hasRoute => _routePoints.isNotEmpty;

  // ---------- Setters with notify ----------
  void setStartPoint(LatLng point) {
    _startPoint = point;
    _clearRoute(); // route becomes invalid when start changes
    notifyListeners();
  }

  void setDestinationPoint(LatLng? point) {
    _destinationPoint = point;
    if (point != null) {
      _fetchRoute(); // recalc route from start to new destination
    } else {
      _clearRoute();
    }
    notifyListeners();
  }

  // ---------- Search (OSM Nominatim) ----------
  Future<void> searchSuggestions(String query) async {
    if (query.length < 2) {
      _suggestions = [];
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
        _suggestions = json.decode(response.body);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("❌ خطأ البحث المحلي: $e");
    }
  }

  void clearSuggestions() {
    _suggestions = [];
    notifyListeners();
  }

  // ---------- Select a suggestion (sets either start or destination) ----------
  void selectAsStartPoint(dynamic item) {
    final lat = double.parse(item['lat']);
    final lon = double.parse(item['lon']);
    setStartPoint(LatLng(lat, lon));
    clearSuggestions();
  }

  void selectAsDestination(dynamic item) {
    final lat = double.parse(item['lat']);
    final lon = double.parse(item['lon']);
    setDestinationPoint(LatLng(lat, lon));
    clearSuggestions();
  }

  // ---------- Route logic (OSRM) ----------
  Future<void> _fetchRoute() async {
    if (_destinationPoint == null) return;

    final start = _startPoint;
    final dest = _destinationPoint!;

    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${start.longitude},${start.latitude};'
      '${dest.longitude},${dest.latitude}'
      '?overview=full&geometries=polyline',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final route = data['routes'][0];

        _routePoints = _decodePolyline(route['geometry']);
        _distance = "${(route['distance'] / 1000).toStringAsFixed(1)} كم";
        _duration = "${(route['duration'] / 60).toStringAsFixed(0)} دقيقة";
        notifyListeners();
      }
    } catch (e) {
      debugPrint("❌ خطأ في حساب الطريق: $e");
    }
  }

  void _clearRoute() {
    _routePoints = [];
    _distance = "";
    _duration = "";
    _destinationPoint = null;
  }

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
}