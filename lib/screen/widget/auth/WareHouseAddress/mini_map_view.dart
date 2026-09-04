import 'package:client_app/core/servers/app_servers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MiniMapView extends StatefulWidget {
  final LatLng initialLocation;
  final bool isInteractive;

  const MiniMapView({
    super.key,
    required this.initialLocation,
    this.isInteractive = true,
  });

  @override
  State<MiniMapView> createState() => _MiniMapViewState();
}

class _MiniMapViewState extends State<MiniMapView> {
  late MapController _mapController;
  late LatLng _selectedPoint;

  LatLng? getSavedLatLng(BuildContext context) {
    final appServices = Provider.of<AppServices>(context, listen: false);

    final latitude = appServices.shared.getDouble('latitude');
    final longitude = appServices.shared.getDouble('longitude');

    if (latitude == null || longitude == null) {
      return null;
    }

    return LatLng(latitude, longitude);
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _selectedPoint = getSavedLatLng(context) ?? widget.initialLocation;

    // Center map on initial location after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(_selectedPoint, 14.0);
    });
  }

  @override
  void didUpdateWidget(MiniMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialLocation != widget.initialLocation) {
      setState(() {
        _selectedPoint = widget.initialLocation;
        _mapController.move(_selectedPoint, 14.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _selectedPoint,
          initialZoom: 14.0,
          onTap: widget.isInteractive
              ? (tapPosition, point) {
                  setState(() {
                    _selectedPoint = point;
                  });
                }
              : null,
          interactionOptions: InteractionOptions(
            flags: widget.isInteractive
                ? InteractiveFlag.all
                : InteractiveFlag
                      .none, // Disable interaction if not interactive
          ),
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
              Marker(
                rotate: true,
                point: _selectedPoint,
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
    );
  }
}
