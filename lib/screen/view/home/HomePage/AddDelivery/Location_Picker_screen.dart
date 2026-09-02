import 'package:client_app/models/map_model.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/route_map_screen.dart';
import 'package:client_app/screen/widget/Map/location_button.dart';
import 'package:client_app/screen/widget/Map/map_view.dart';
import 'package:client_app/screen/widget/Map/map_search_bar.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class LocationPickerScreen extends StatelessWidget {
  final bool? isForLogin;
  final Function(LatLng, String)? onLocationSelected;

  const LocationPickerScreen({
    super.key,
    this.isForLogin,
    this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapModelImpl(context),
      child: LocationPickerScreenView(
        isForLogin: isForLogin!,
        onLocationSelected: onLocationSelected,
      ),
    );
  }
}

class LocationPickerScreenView extends StatelessWidget {
  final bool isForLogin;
  final Function(LatLng, String)? onLocationSelected;

  const LocationPickerScreenView({
    super.key,
    required this.isForLogin,
    this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final mapModel = context.read<MapModelImpl>();
    return Scaffold(
      body: Consumer<MapModelImpl>(
        builder: (BuildContext context, MapModelImpl value, Widget? child) {
          return Stack(
            children: [
              MapView(),
              MapSearchBar(),
              LocationButton(),
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: ContinueButton(
                  onTap: () async {
                    print(
                      "تم اختيار الموقع: ${mapModel.selectedPoint.latitude}, ${mapModel.selectedPoint.longitude}",
                    );

                    // Get address from coordinates
                    final address = await mapModel.getAddressFromLatLng(
                      mapModel.selectedPoint,
                    );

                    if (isForLogin) {
                      mapModel.saveLatLng(mapModel.selectedPoint, context);

                      // Pass location back through callback
                      if (onLocationSelected != null) {
                        onLocationSelected!(mapModel.selectedPoint, address);
                      }

                      Navigator.pop(context); // Just pop the bottom sheet
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RouteMapScreen(
                            pickUpPoint: mapModel.selectedPoint,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
