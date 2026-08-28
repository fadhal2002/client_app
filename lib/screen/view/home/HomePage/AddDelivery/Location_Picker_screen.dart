import 'package:client_app/models/map_model.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/route_map_screen.dart';
import 'package:client_app/screen/widget/Map/location_button.dart';
import 'package:client_app/screen/widget/Map/map_view.dart';
import 'package:client_app/screen/widget/Map/map_search_bar.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationPickerScreen extends StatelessWidget {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapModelImpl(context),
      child: const LocationPickerScreenView(),
    );
  }
}

class LocationPickerScreenView extends StatelessWidget {
  const LocationPickerScreenView({super.key});

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

              // Continue Button at bottom
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: ContinueButton(
                  onTap: () {
                    print(
                      "تم اختيار الموقع: ${mapModel.selectedPoint.latitude}, ${mapModel.selectedPoint.longitude}",
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RouteMapScreen(pickUpPoint: mapModel.selectedPoint),
                      ),
                    );
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
