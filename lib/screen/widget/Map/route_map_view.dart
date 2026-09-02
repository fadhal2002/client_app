import 'package:client_app/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class RouteMapView extends StatelessWidget {
  final LatLng pickUpPoint;
  const RouteMapView({super.key, required this.pickUpPoint});

  @override
  Widget build(BuildContext context) {
    final mapModel = context.read<MapModelImpl>();
    return FlutterMap(
      mapController: mapModel.mapController2,
      options: MapOptions(
        initialCenter: pickUpPoint,
        initialZoom: 12.0,
        onTap: (tapPosition, point) {
          print("نقطة الوصول مختارة: ${point.latitude}, ${point.longitude}");
          mapModel.getRoute(point, pickUpPoint);
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
          polylines: mapModel.routePoints.isEmpty
              ? <Polyline>[]
              : <Polyline>[
                  Polyline(
                    points: mapModel.routePoints,
                    strokeWidth: 5,
                    color: Colors.blueAccent,
                  ),
                ],
        ),
        MarkerLayer(
          markers: [
            // Pickup marker (Green)
            Marker(
              rotate: true,
              point: pickUpPoint,
              width: 50,
              height: 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.6),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Dropoff marker (Red)
            if (mapModel.dropOffPoint != null)
              Marker(
                rotate: true,
                point: mapModel.dropOffPoint!,
                width: 50,
                height: 90,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
