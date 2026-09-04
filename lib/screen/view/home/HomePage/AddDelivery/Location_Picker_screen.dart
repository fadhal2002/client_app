import 'package:client_app/models/map_model.dart';
import 'package:client_app/screen/widget/Map/location_button.dart';
import 'package:client_app/screen/widget/Map/map_view.dart';
import 'package:client_app/screen/widget/Map/map_search_bar.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class LocationPickerScreen extends StatelessWidget {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LocationPickerScreenView();
  }
}

class LocationPickerScreenView extends StatelessWidget {
  const LocationPickerScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final mapModel = context.read<MapModelImpl>();
    return Scaffold(
      body: Stack(
        children: [
          Selector<MapModelImpl, LatLng?>(
            selector: (context, model) => model.selectedPoint,
            builder: (context, selectedPoint, child) {
              return MapView();
            },
          ),
          MapSearchBar(),
          Selector<MapModelImpl, bool>(
            selector: (context, model) => model.isLoading,
            builder: (context, isLoading, child) {
              return LocationButton();
            },
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ContinueButton(
              onTap: () async {
                print(
                  "تم اختيار الموقع: ${mapModel.selectedPoint.latitude}, ${mapModel.selectedPoint.longitude}",
                );

                mapModel.saveLatLng(mapModel.selectedPoint, context);

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
