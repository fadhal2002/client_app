import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RouteMapScreen extends StatefulWidget {
  LatLng? selectedPoint;
  RouteMapScreen({super.key, this.selectedPoint});

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _suggestions = [];

  LatLng get _selectedPoint =>
      widget.selectedPoint ?? const LatLng(32.0259, 44.3615);

  List<LatLng> _routePoints = [];
  String _distance = "";
  String _duration = "";

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

  Future<void> _getRoute(LatLng destination) async {
    final start = _selectedPoint;

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

  void _selectLocation(dynamic item) {
    final double lat = double.parse(item['lat']);
    final double lon = double.parse(item['lon']);
    final destination = LatLng(lat, lon);

    LatLng _selectedPoint =
        widget.selectedPoint ?? const LatLng(32.0259, 44.3615);

    setState(() {
      _selectedPoint = destination;
      _suggestions = [];
      _searchController.text = item['display_name'];
    });

    _mapController.move(_selectedPoint, 15.0);
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
              initialCenter: _selectedPoint,
              initialZoom: 12.0,
              onTap: (tapPosition, point) {
                LatLng _selectedPoint =
                    widget.selectedPoint ?? const LatLng(32.0259, 44.3615);
                setState(() => _selectedPoint = point);
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
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 15,
                    ),
                  ),
                  const Marker(
                    point: LatLng(32.0259, 44.3615),
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
                            _distance = "";
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
              onPressed: () {
                print(
                  "الموقع: ${_selectedPoint.latitude}, ${_selectedPoint.longitude} | المسافة: $_distance",
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