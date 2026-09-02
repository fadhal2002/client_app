import 'package:client_app/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final mapModel = context.watch<MapModelImpl>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FlutterMap(
            mapController: mapModel.mapController,
            options: MapOptions(
              initialCenter:
                  mapModel.getSavedLatLng(context) ?? mapModel.selectedPoint,
              initialZoom: mapModel.currentZoom,
              onTap: (tapPosition, point) {
                mapModel.changeSelectedPoint(point);
              },
              onPositionChanged: (position, hasGesture) {
                mapModel.changeZoom(position.zoom);
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=aebbd3c90ecb423494467f5a30f64bb2',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.pondo.ai',
              ),

              MarkerLayer(
                markers: [
                  // Pickup marker (selected point)
                  Marker(
                    rotate: true,
                    point: mapModel.selectedPoint,
                    width: 50,
                    height: 50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4F46E5),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4F46E5).withOpacity(0.4),
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
                            color: const Color(0xFF4F46E5),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4F46E5).withOpacity(0.6),
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
          ),
        ),
      ),
    );
  }
}
